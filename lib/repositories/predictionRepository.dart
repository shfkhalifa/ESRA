import 'package:esra/api/userApiClient.dart';
import 'package:esra/models/assessment.dart';
import 'package:esra/models/prediction.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

///
///SQlite should be use here to store user data locally
///

class PredictionRepository {
  UserApiClient userApiClient = UserApiClient();
  final storage = new FlutterSecureStorage();
  final String predictionDateKey = "date";
  final String predictionLabelKey = "label";
  final String predictionScoreKey = "score";
  final String predictionImageKey = "image";

  PredictionRepository();

  Future<Prediction> getPrediction(String imagePath) async {
    return await userApiClient.getPrediction(imagePath);
  }

  ///
  ///Send feedback
  ///
  Future<void> sendFeedback({
    @required String childId,
    @required String imagePath,
    @required String feedbackMsg,
    @required Prediction prediction,
    @required String token,
  }) async {
    await userApiClient.sendFeedback(
      childId: childId,
      imagePath: imagePath,
      feedbackMsg: feedbackMsg,
      prediction: prediction,
      token: token,
    );
  }

  Future<void> savePrediction({
    String imagePath,
    Prediction prediction,
    String childId,
    AssessmentRecord assessment,
  }) async {
    await userApiClient.savePrediction(
      imagePath: imagePath,
      prediction: prediction,
      childId: childId,
      assessment: assessment,
    );
  }
}
