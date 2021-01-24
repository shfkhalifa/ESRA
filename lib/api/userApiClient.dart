import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:esra/api/generateImageUrl.dart';
import 'package:esra/api/uploadFile.dart';
import 'package:esra/models/assessment.dart';
import 'package:path/path.dart' as path;
import 'package:esra/models/child.dart';
import 'package:esra/models/faq.dart';
import 'package:esra/models/prediction.dart';
import 'package:esra/utils/constants.dart';
import 'package:esra/utils/errorHandler.dart';
import 'package:esra/utils/userFromJWT.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:http_retry/http_retry.dart';

class UserApiClient {
  /// The [httpClient] is set once form [HomePage] in the [initState()] function
  static http.Client httpClient;
  UserApiClient() {
    if (httpClient == null) httpClient = http.Client();
  }

  ///_______________________________________
  /// Close httpClient connection
  ///---------------------------------------
  static closeClient() {
    httpClient?.close();
  }

  ///_______________________________________
  /// Register a New User
  ///---------------------------------------
  Future<String> registerUser({
    @required String email,
    @required String password,
  }) async {
    http.Response response;
    // Error catchin should happen at this level!!
    try {
      response = await httpClient.post(
        Strings.SERVER_URL + Strings.REGISTER_USER_URI,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: json.encode({"email": email, "password": password}),
      );

      if (response.statusCode != 200)
        throw ErrorHandler(json.decode(response.body)['errorMsg']);

      return response.body;
    } on SocketException {
      throw ErrorHandler(Strings.NO_INTERNET_ERROR);
    } on HttpException {
      throw ErrorHandler("Bad request");
    } on FormatException {
      throw ErrorHandler("Bad request end point");
    }
  }

  ///_______________________________________
  /// User Login
  ///---------------------------------------
  Future<String> login(String email, String password) async {
    http.Response response;
    try {
      response = await httpClient.post(
        Strings.SERVER_URL + Strings.LOGIN_USER_URI,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: json.encode({"email": email, "password": password}),
      );
      if (response.statusCode != 200) {
        throw ErrorHandler(json.decode(response.body)['errorMsg']);
      }
      return json.decode(response.body)['token'];
    } on SocketException {
      throw ErrorHandler(Strings.NO_INTERNET_ERROR);
    } on HttpException {
      throw ErrorHandler("Bad request");
    } on FormatException {
      throw ErrorHandler("Bad response");
    }
  }

  ///_______________________________________
  /// Activate user account
  ///---------------------------------------
  Future<String> activateUser(String email) async {
    http.Response response;
    try {
      response = await httpClient.post(
        Strings.SERVER_URL + Strings.ACTIVATE_USER_URI,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: json.encode({"email": email}),
      );
      if (response.statusCode != 200) {
        throw ErrorHandler(json.decode(response.body)['errorMsg']);
      }
      return response.body;
    } on SocketException {
      throw ErrorHandler(Strings.NO_INTERNET_ERROR);
    } on HttpException {
      throw ErrorHandler("Bad request");
    } on FormatException {
      throw ErrorHandler("Bad response");
    }
  }

  ///_______________________________________
  /// Get User Data
  ///---------------------------------------
  Future<List<Child>> getChildren(String token) async {
    http.Response response;
    String parentId = getUserIdFromToken(token);
    try {
      response = await httpClient.post(
        Strings.SERVER_URL + Strings.GET_USER_URI,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          // HttpHeaders.authorizationHeader: token,
        },
        body: json.encode({
          "userId": parentId,
        }),
      );
      if (response.statusCode != 200) {
        throw ErrorHandler(json.decode(response.body)['errorMsg']);
      }
      return List<Child>.from(
          json.decode(response.body)['children'].map((x) => Child.fromJson(x)));
    } on SocketException {
      throw ErrorHandler(Strings.NO_INTERNET_ERROR);
    } on HttpException {
      throw ErrorHandler("Bad request");
    } on FormatException {
      throw ErrorHandler("Bad response");
    }
  }

  ///_______________________________________
  /// Add a child
  ///---------------------------------------
  Future<int> addNewChild(
      String childName, String dob, String childGender, String token) async {
    http.Response response;
    String parentId = getUserIdFromToken(token);
    try {
      response = await httpClient.post(
        Strings.SERVER_URL + Strings.ADD_CHILD_URI,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token,
        },
        body: json.encode({
          "name": childName,
          "dob": dob,
          "gender": childGender,
          "parentId": parentId,
        }),
      );
      if (response.statusCode != 200) {
        throw ErrorHandler(json.decode(response.body)['errorMsg']);
      }
      return json.decode(response.body)['childrenCount'];
    } on SocketException {
      throw ErrorHandler(Strings.NO_INTERNET_ERROR);
    } on HttpException {
      throw ErrorHandler("Bad request");
    } on FormatException {
      throw ErrorHandler("Bad response");
    }
  }

  ///_______________________________________
  /// Get prediction
  ///---------------------------------------
  Future<Prediction> getPrediction(String imagePath) async {
    File image = File(imagePath);
    if (image != null) {
      String fileExtension = path.extension(image.path);
      String uploadUrl;
      GenerateImageUrl generateImageUrl = GenerateImageUrl();

      try {
        // GenerateImageUrl generateImageUrl = GenerateImageUrl();
        await generateImageUrl.call(fileExtension, "myesra");

        if (generateImageUrl.isGenerated != null &&
            generateImageUrl.isGenerated) {
          uploadUrl = generateImageUrl.uploadUrl;
        } else {
          throw generateImageUrl.message;
        }

        bool isUploaded = await uploadFile(uploadUrl, image);
        if (isUploaded) {
          print('Uploaded');
        }
      } catch (e) {
        print(e);
      }
      // var request = http.MultipartRequest(
      //   "POST",
      //   Uri.parse(Strings.SERVER_URL + Strings.PREDICTION_URI),
      // );

      // request.files.add(
      //   http.MultipartFile.fromBytes(
      //     "img",
      //     image.readAsBytesSync(),
      //     filename: image.path.split("/").last,
      //   ),
      // );

      try {
        // http.StreamedResponse response = await request.send();
        var url = Strings.INFERENCE_URL;
        var body = json.encode({
          "url": generateImageUrl.downloadUrl,
        });

        var client = new RetryClient(new http.Client(), retries: 3,
            when: (http.BaseResponse response) {
          return response.statusCode == 504;
        });
        var response = await client.post(
          url,
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
          },
          body: body,
        );

        var hmResponse = await httpClient.post(Strings.HEATMAP_URL,
            //'http://192.168.138.129:5000/heatmap', //local host
            headers: {
              'Content-Type': 'application/json',
            },
            body: body);

        String hmBasefile = path.basename(image.path);
        hmBasefile = 'hm_' + hmBasefile;
        String imageDir = path.dirname(image.path);

        File file = new File('$imageDir/$hmBasefile');
        //print(hmResponse.statusCode);
        await file.writeAsBytes(hmResponse.bodyBytes);
        print('heatmap file saved in : ${file.path}');

        Prediction prediction = Prediction.fromJson(jsonDecode(response.body));
        prediction.imagePath = imagePath;
        return prediction;
      } on SocketException {
        throw ErrorHandler(Strings.NO_INTERNET_ERROR);
      } on HttpException {
        throw ErrorHandler("Bad request");
      } on FormatException {
        throw ErrorHandler("Bad response");
      }
    }
  }

  ///_______________________________________
  /// Get prediction
  ///---------------------------------------
  Future<void> savePrediction({
    String imagePath,
    Prediction prediction,
    String childId,
    AssessmentRecord assessment,
    String assessAvailable,
  }) async {
    File image = File(imagePath);
    if (image != null) {
      String fileExtension = path.extension(image.path);
      String uploadUrl;
      GenerateImageUrl generateImageUrl = GenerateImageUrl();

      try {
        await generateImageUrl.call(fileExtension, "esrasavepredictionbucket");

        if (generateImageUrl.isGenerated != null &&
            generateImageUrl.isGenerated) {
          uploadUrl = generateImageUrl.uploadUrl;
        } else {
          throw generateImageUrl.message;
        }

        bool isUploaded = await uploadFile(uploadUrl, image);
        if (isUploaded) {
          print('Uploaded');
        }
      } catch (e) {
        print(e);
      }
    }

    http.Response response;
    try {
      response = await httpClient.post(
        Strings.SERVER_URL + Strings.SAVE_PREDICTION_URI,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          //HttpHeaders.authorizationHeader: token,
        },
        body: json.encode({
          "score": (prediction.score * 100).round().toString(),
          "label": prediction.label,
          "childId": childId,
          "imagePath": imagePath,
          "assessAvailable": assessAvailable,
          "isChildInPhoto":
              (assessment == null) ? null : assessment.isChildInPhoto,
          "feeling": (assessment == null) ? null : assessment.feeling,
          "hasStory": (assessment == null) ? null : assessment.hasStory,
          "isSpontaneous":
              (assessment == null) ? null : assessment.isSpontaneous,
          "isInGroup": (assessment == null) ? null : assessment.isInGroup,
          "isBeforeSchool":
              (assessment == null) ? null : assessment.isBeforeSchool
        }),
      );
      if (response.statusCode != 200) {
        throw ErrorHandler(json.decode(response.body)['errorMsg']);
      }
      return json.decode(response.body);
    } on SocketException {
      throw ErrorHandler(Strings.NO_INTERNET_ERROR);
    } on HttpException {
      throw ErrorHandler("Bad request");
    } on FormatException {
      throw ErrorHandler("Bad response");
    }
  }

  ///_______________________________________
  /// Send feedback
  ///---------------------------------------
  Future<void> sendFeedback({
    @required String childId,
    @required String imagePath,
    @required String feedbackMsg,
    @required Prediction prediction,
    @required String token,
  }) async {
    //print('$childId, $imagePath, $feedbackMsg, $prediction, $token');
    String parentId = getUserIdFromToken(token);

    File image = File(imagePath);
    if (image != null) {
      String fileExtension = path.extension(image.path);
      String uploadUrl;
      GenerateImageUrl generateImageUrl = GenerateImageUrl();

      try {
        // GenerateImageUrl generateImageUrl = GenerateImageUrl();
        await generateImageUrl.call(fileExtension, "esrafeedbackimages");

        if (generateImageUrl.isGenerated != null &&
            generateImageUrl.isGenerated) {
          uploadUrl = generateImageUrl.uploadUrl;
        } else {
          throw generateImageUrl.message;
        }

        bool isUploaded = await uploadFile(uploadUrl, image);
        if (isUploaded) {
          print('Uploaded');
        }
      } catch (e) {
        print(e);
      }
    }
    var request = http.MultipartRequest(
      "POST",
      Uri.parse(Strings.SERVER_URL + Strings.SAVE_FEEDBACK_URI),
    );
    request.fields['predictionScore'] =
        (prediction.score * 100).round().toString();
    request.fields['predictionLabel'] = prediction.label;
    request.fields['userId'] = parentId;
    request.fields['childId'] = childId;
    request.fields['feedbackMsg'] = feedbackMsg;
    request.files.add(
      http.MultipartFile.fromBytes(
        "img",
        image.readAsBytesSync(),
        filename: image.path.split("/").last,
      ),
    );

    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode != 200) {
        print('${response.statusCode}');
        var responseContent = await response.stream.bytesToString();
        print(json.decode(responseContent));
        //throw ErrorHandler(Strings.SOMETHING_WENT_WRONG);
      }
      var responseContent = await response.stream.bytesToString();
      print(json.decode(responseContent));
    } on SocketException {
      throw ErrorHandler(Strings.NO_INTERNET_ERROR);
    } on HttpException {
      throw ErrorHandler("Bad request");
    } on FormatException {
      throw ErrorHandler("Bad response");
    }
  }

  ///
  /// Get List of all faqs
  ///

  Future<List<Faq>> getFaqs() async {
    http.Response response;
    try {
      response = await httpClient.get(
        Strings.SERVER_URL + Strings.GET_FAQS,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          // HttpHeaders.authorizationHeader: token,
        },
      );
      if (response.statusCode != 200) {
        throw ErrorHandler(json.decode(response.body)['errorMsg']);
      }
      return List<Faq>.from(
          json.decode(response.body)['faqs'].map((x) => Faq.fromJson(x)));
    } on SocketException {
      throw ErrorHandler(Strings.NO_INTERNET_ERROR);
    } on HttpException {
      throw ErrorHandler("Bad request");
    } on FormatException {
      throw ErrorHandler("Bad response");
    }
  }
}
