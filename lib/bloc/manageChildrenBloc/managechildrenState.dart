import 'package:meta/meta.dart';
import 'package:esra/models/child.dart';

@immutable
class ManagechildrenState {
  final bool isChildNameValid;
  final bool isDOBValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String errorMsg;
  final List<Child> childrenList;
  final bool isLoadingChildren;

  bool get isFormValid => isChildNameValid && isDOBValid;

  ManagechildrenState({
    @required this.isChildNameValid,
    @required this.isDOBValid,
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
      isDOBValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      childrenList: [],
    );
  }

  factory ManagechildrenState.loading() {
    return ManagechildrenState(
      isChildNameValid: true,
      isDOBValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory ManagechildrenState.failure({String errorMsg}) {
    return ManagechildrenState(
      isChildNameValid: true,
      isDOBValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      errorMsg: errorMsg,
    );
  }

  factory ManagechildrenState.success({List<Child> childrenList}) {
    return ManagechildrenState(
        isChildNameValid: true,
        isDOBValid: true,
        isSubmitting: false,
        isSuccess: true,
        isFailure: false,
        childrenList: childrenList);
  }

  ManagechildrenState update({
    bool isChildNameValid,
    bool isDOBValid,
    List<Child> childrenList,
    bool isLoadingchildren,
  }) {
    return copyWith(
        isChildNameValid: isChildNameValid,
        isDOBValid: isDOBValid,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        childrenList: childrenList,
        isloadingChildrent: isLoadingchildren);
  }

  ManagechildrenState copyWith({
    bool isChildNameValid,
    bool isDOBValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
    List<Child> childrenList,
    bool isloadingChildrent,
  }) {
    return ManagechildrenState(
      isChildNameValid: isChildNameValid ?? this.isChildNameValid,
      isDOBValid: isDOBValid ?? this.isDOBValid,
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
      isDOBValid: $isDOBValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      childrenList: $childrenList,
    }''';
  }
}
