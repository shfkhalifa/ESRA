import 'package:meta/meta.dart';
import 'package:esra/models/child.dart';

@immutable
class ManagechildrenState {
  final bool isChildNameValid;
  final bool isChildAgeValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String errorMsg;
  final List<Child> childrenList;
  final bool isLoadingChildren;

  bool get isFormValid => isChildNameValid && isChildAgeValid;

  ManagechildrenState({
    @required this.isChildNameValid,
    @required this.isChildAgeValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
    this.isLoadingChildren,
    this.errorMsg,
    this.childrenList,
  });

  factory ManagechildrenState.empty() {
    return ManagechildrenState(
      isChildNameValid: true,
      isChildAgeValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      childrenList: [],
    );
  }

  factory ManagechildrenState.loading() {
    return ManagechildrenState(
      isChildNameValid: true,
      isChildAgeValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory ManagechildrenState.failure({String errorMsg}) {
    return ManagechildrenState(
      isChildNameValid: true,
      isChildAgeValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      errorMsg: errorMsg,
    );
  }

  factory ManagechildrenState.success({List<Child> childrenList}) {
    return ManagechildrenState(
        isChildNameValid: true,
        isChildAgeValid: true,
        isSubmitting: false,
        isSuccess: true,
        isFailure: false,
        childrenList: childrenList);
  }

  ManagechildrenState update({
    bool isChildNameValid,
    bool isChildAgeValid,
    List<Child> childrenList,
    bool isLoadingchildren,
  }) {
    return copyWith(
        isChildNameValid: isChildNameValid,
        isChildAgeValid: isChildAgeValid,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        childrenList: childrenList,
        isloadingChildrent: isLoadingchildren);
  }

  ManagechildrenState copyWith({
    bool isChildNameValid,
    bool isChildAgeValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
    List<Child> childrenList,
    bool isloadingChildrent,
  }) {
    return ManagechildrenState(
      isChildNameValid: isChildNameValid ?? this.isChildNameValid,
      isChildAgeValid: isChildAgeValid ?? this.isChildAgeValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      childrenList: childrenList ?? this.childrenList,
      isLoadingChildren: isloadingChildrent ?? this.isLoadingChildren,
    );
  }

  @override
  String toString() {
    return '''ManagechildrenSate {
      isChildNameValid: $isChildNameValid,
      isChildAgeValid: $isChildAgeValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      childrenList: $childrenList,
    }''';
  }
}
