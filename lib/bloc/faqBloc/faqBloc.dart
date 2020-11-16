import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:esra/bloc/faqBloc/faq.dart';
import 'package:esra/models/faq.dart';
import 'package:esra/repositories/userRepository.dart';

class FaqBloc extends Bloc<FaqEvent, FaqState> {
  UserRepository _userRepository;

  FaqBloc(UserRepository userRepository)
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  FaqState get initialState => FaqState.empty();

  @override
  Stream<FaqState> mapEventToState(
    FaqEvent event,
  ) async* {
    if (event is LoadFaq) {
      yield* _mapLoadFaqToState();
    }
  }

  Stream<FaqState> _mapLoadFaqToState() async* {
    yield FaqState.loading();
    try {
      List<Faq> faqs = await _userRepository.getFaqList();
      yield FaqState.loaded(faqs);
    } catch (e) {
      // if any error
      yield FaqState.error(e.toString());
    }
  }
}
