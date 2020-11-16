import 'package:meta/meta.dart';
import 'package:esra/models/faq.dart';

@immutable
class FaqState {
  final bool isLoading;
  final bool loaded;
  final bool error;
  final List<Faq> faqList;
  final String errorMsg;

  FaqState({
    @required this.isLoading,
    @required this.loaded,
    @required this.error,
    this.faqList,
    this.errorMsg,
  });

  factory FaqState.empty() => FaqState(
        error: false,
        isLoading: false,
        loaded: false,
        faqList: [],
      );

  factory FaqState.loading() => FaqState(
        error: false,
        isLoading: true,
        loaded: false,
        faqList: [],
      );

  factory FaqState.loaded(List<Faq> faqList) => FaqState(
        error: false,
        isLoading: false,
        loaded: true,
        faqList: faqList,
      );

  factory FaqState.error(String errorMsg) => FaqState(
        error: true,
        isLoading: false,
        loaded: false,
        errorMsg: errorMsg,
      );
}
