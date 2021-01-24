import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:esra/models/prediction.dart';
import 'package:esra/repositories/predictionRepository.dart';
import 'package:meta/meta.dart';
import './prediction.dart';

class PredictionBloc extends Bloc<PredictionEvent, PredictionState> {
  PredictionRepository _predictionRepository;

  PredictionBloc(PredictionRepository predictionRepository)
      : assert(predictionRepository != null),
        _predictionRepository = predictionRepository;
  @override
  PredictionState get initialState => PredictionState.init();

  @override
  Stream<PredictionState> mapEventToState(
    PredictionEvent event,
  ) async* {
    if (event is GetPrediction) {
      yield* _mapGetPredictionToState(event.imagePath);
    }
    if (event is SavePredictionSuccess) {
      yield* _mapSavePredictionSuccessToState(
        imagePath: event.imagePath,
        prediction: event.prediction,
        childId: event.childId,
        assessment: event.assessment,
        assessAvailable: event.assessAvailable,
      );
    }
    if (event is DismissPrediction) {
      yield* _mapDismissPredictionToState();
    }
    if (event is SavePrediction) {
      yield* _mapSavePredictionToState();
    }
    if (event is SendFeedback) {
      yield* _mapSendFeedbackToState(
        childId: event.childId,
        imagePath: event.imagePath,
        feedbackMsg: event.feedbackMsg,
        prediction: event.prediction,
        token: event.token,
      );
    }
  }

  Stream<PredictionState> _mapGetPredictionToState(String imagePath) async* {
    yield PredictionState.loading();
    try {
      Prediction prediction =
          await _predictionRepository.getPrediction(imagePath);
      yield PredictionState.success(prediction);
    } catch (e) {
      yield PredictionState.failure(e.toString());
    }
  }

  Stream<PredictionState> _mapDismissPredictionToState() async* {
    yield PredictionState.loading();
    try {
      yield state.dismissed();
    } catch (e) {
      yield PredictionState.failure(e.toString());
    }
  }

  Stream<PredictionState> _mapSavePredictionToState() async* {
    yield PredictionState.loading();
    try {
      yield state.saved();
    } catch (e) {
      yield PredictionState.failure(e.toString());
    }
  }

  Stream<PredictionState> _mapSendFeedbackToState({
    @required String childId,
    @required String imagePath,
    @required String feedbackMsg,
    @required Prediction prediction,
    @required String token,
  }) async* {
    yield PredictionState.loading();
    try {
      await _predictionRepository.sendFeedback(
        childId: childId,
        imagePath: imagePath,
        feedbackMsg: feedbackMsg,
        prediction: prediction,
        token: token,
      );
      yield PredictionState.feedbackSent();
    } catch (e) {
      yield PredictionState.failure(e.toString());
    }
  }

  Stream<PredictionState> _mapSavePredictionSuccessToState({
    imagePath,
    prediction,
    childId,
    assessment,
    assessAvailable,
  }) async* {
    yield PredictionState.loading();
    try {
      await _predictionRepository.savePrediction(
          imagePath: imagePath,
          prediction: prediction,
          childId: childId,
          assessment: assessment,
          assessAvailable: assessAvailable);
      yield PredictionState.predictionSavedSuccess();
    } catch (e) {
      yield PredictionState.failure(e.toString());
    }
  }
}
