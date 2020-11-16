import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:esra/utils/constants.dart';

class GenerateImageUrl {
  bool success;
  String message;

  bool isGenerated;

  String uploadUrl;
  String downloadUrl;

  Future<void> call(String fileType, String bucketName) async {
    try {
      Map body = {"fileType": fileType, "bucketName": bucketName};

      var response = await http.post(
        //For IOS
//       ///// 'http://localhost:5000/generatePresignedUrl',
        //For Android
        //'http://10.0.2.2:5000/generatePresignedUrl',
        Strings.SERVER_URL + Strings.GET_PRESIGNED_URL,
        body: body,
      );

      var result = jsonDecode(response.body);

      print(result);

      if (result['success'] != null) {
        success = result['success'];
        message = result['message'];

        if (response.statusCode == 201) {
          isGenerated = true;
          uploadUrl = result["uploadUrl"];
          downloadUrl = result["downloadUrl"];
        }
      }
    } catch (e) {
      throw ('Error getting url');
    }
  }
}
