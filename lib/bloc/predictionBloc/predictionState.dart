import 'package:esra/models/prediction.dart';
import 'package:meta/meta.dart';

@immutable
class PredictionState {
  final Prediction prediction;
  final bool isPredicting;
  final bool isSuccess;
  final bool isFailure;
  final String errorMsg;
  final bool isPredictionDismissed;
  final bool isFeedbackSent;
  final bool isPredictionSavedSuccess;
  final bool isPredictionSaved;

  PredictionState({
    @required this.isPredicting,
    @required this.isSuccess,
    @required this.isFailure,
    @required this.isPredictionDismissed,
    this.isPredictionSaved,
    this.isPredictionSavedSuccess,
    this.prediction,
    this.isFeedbackSent,
    this.errorMsg,
  });

  factory PredictionState.init() {
    return PredictionState(
      isPredicting: false,
      isSuccess: false,
      isFailure: false,
      isPredictionDismissed: false,
      isFeedbackSent: false,
      isPredictionSaved: false,
      isPredictionSavedSuccess: false,
    );
  }

  factory PredictionState.loading() {
    return PredictionState(
      isPredicting: true,
      isSuccess: false,
      isFailure: false,
      isPredictionDismissed: false,
      isPredictionSaved: false,
      isPredictionSavedSuccess: false,
    );
  }

  factory PredictionState.failure(String errorMsg) {
    return PredictionState(
      isPredicting: false,
      isSuccess: false,
      isFailure: true,
      errorMsg: errorMsg,
      isPredictionDismissed: false,
      isPredictionSaved: false,
      isPredictionSavedSuccess: false,
    );
  }
  factory PredictionState.success(Prediction prediction) {
    return PredictionState(
      isPredicting: false,
      isSuccess: true,
      isFailure: false,
      isPredictionDismissed: false,
      prediction: prediction,
      isPredictionSaved: false,
      isPredictionSavedSuccess: false,
    );
  }

  PredictionState dismissed() {
    return copyWith(
      isPredicting: false,
      isSuccess: false,
      isFailure: false,
      isPredictionDismissed: true,
    );
  }

  PredictionState saved() {
    return copyWith(
      isPredicting: false,
      isSuccess: false,
      isFailure: false,
      isPredictionSaved: true,
    );
  }

  factory PredictionState.feedbackSent() {
    return PredictionState(
      isPredicting: false,
      isSuccess: false,
      isFailure: false,
      isPredictionDismissed: false,
      isFeedbackSent: true,
      isPredictionSaved: false,
      isPredictionSavedSuccess: false,
    );
  }

  factory PredictionState.predictionSavedSuccess() {
    return PredictionState(
      isPredicting: false,
      isSuccess: false,
      isFailure: false,
      isPredictionDismissed: false,
      isFeedbackSent: false,
      isPredictionSaved: false,
      isPredictionSavedSuccess: true,
    );
  }

  factory PredictionState.predictionSaved() {
    return PredictionState(
      isPredicting: false,
      isSuccess: false,
      isFailure: false,
      isPredictionDismissed: false,
      isFeedbackSent: false,
      isPredictionSaved: true,
      isPredictionSavedSuccess: false,
    );
  }

  PredictionState copyWith({
    Prediction prediction,
    bool isPredicting,
    bool isSuccess,
    bool isFailure,
    bool isPredictionDismissed,
    bool isPredictionSaved,
  }) {
    return PredictionState(
      prediction: prediction ?? this.prediction,
      isPredicting: isPredicting ?? this.isPredicting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      isPredictionDismissed:
          isPredictionDismissed ?? this.isPredictionDismissed,
      isPredictionSaved: isPredictionSaved ?? this.isPredictionSaved,
      isPredictionSavedSuccess: false,
    );
  }

  @override
  String toString() {
    return '''
    PredictionState {
      isPredicting: $isPredicting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      isPredictionDismissed: $isPredictionDismissed,
      isFeedbackSent: $isFeedbackSent,
      isPredictionSaved: $isPredictionSaved,
      isPredictionSavedSuccess: $isPredictionSavedSuccess,
      errorMsge: $errorMsg,
    }''';
  }
}

// abstract class PredictionState extends Equatable {
//   const PredictionState();
// }

// class PredictionInitial extends PredictionState {
//   @override
//   List<Object> get props => [];
// }

// class PredictionInProgress extends PredictionState {
//   @override
//   List<Object> get props => [];
// }

// class PredictionLoadedSuccess extends PredictionState {
//   final String label;
//   final double score;

//   const PredictionLoadedSuccess({this.label, this.score});
//   @override
//   List<Object> get props => [label, score];
// }

// class PredictionLoadedError extends PredictionState {
//   final String errorString;

//   const PredictionLoadedError({this.errorString});
//   @override
//   List<Object> get props => [errorString];
// }
