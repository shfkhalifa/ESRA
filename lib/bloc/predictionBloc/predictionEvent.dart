import 'package:equatable/equatable.dart';
import 'package:esra/bloc/predictionBloc/prediction.dart';
import 'package:esra/models/assessment.dart';
import 'package:esra/models/prediction.dart';
import 'package:meta/meta.dart';

abstract class PredictionEvent extends Equatable {
  const PredictionEvent();
}

class GetPrediction extends PredictionEvent {
  final String imagePath;

  const GetPrediction({this.imagePath});

  @override
  List<Object> get props => [imagePath];

  @override
  String toString() => 'Label image { todo: $imagePath }';
}

class SavePrediction extends PredictionEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'SavePrediction';
}

class SavePredictionSuccess extends PredictionEvent {
  final String imagePath;
  final Prediction prediction;
  final String childId;
  final AssessmentRecord assessment;
  final String assessAvailable;

  const SavePredictionSuccess(
      {this.imagePath,
      this.prediction,
      this.childId,
      this.assessment,
      this.assessAvailable});

  @override
  List<Object> get props =>
      [imagePath, prediction, childId, assessment, assessAvailable];

  @override
  String toString() =>
      'Label image { imagePath: $imagePath, prediction: $prediction, childId: $childId, assessment: $assessment, assessAvailable: $assessAvailable}';
}

class DismissPrediction extends PredictionEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'DismissPrediction';
}

class SendFeedback extends PredictionEvent {
  final String childId;
  final String imagePath;
  final String feedbackMsg;
  final Prediction prediction;
  final String token;

  SendFeedback(
      {this.childId,
      this.imagePath,
      this.feedbackMsg,
      this.prediction,
      this.token});
  @override
  List<Object> get props => [feedbackMsg];

  @override
  String toString() => 'SendFeedback({$feedbackMsg})';
}
