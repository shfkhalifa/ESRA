import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:esra/models/child.dart';
import 'package:esra/repositories/userRepository.dart';
import 'package:esra/utils/validators.dart';
import './mangeChildren.dart';

class ManagechildrenBloc
    extends Bloc<ManagechildrenEvent, ManagechildrenState> {
  final UserRepository _userRepository;

  ManagechildrenBloc(this._userRepository);

  @override
  ManagechildrenState get initialState => ManagechildrenState.empty();

  @override
  Stream<ManagechildrenState> mapEventToState(
    ManagechildrenEvent event,
  ) async* {
    if (event is ChildNameChanged) {
      yield* _mapChildNameChangedToState(event.childName);
    } else if (event is ChildAgeChanged) {
      yield* _mapChildAgeChangedToState(event.dob);
    }
    // else if (event is ChildrenCountChanged) {
    //   yield* _mapChildrenCountChangedToState(event.childrenList);
    // }
    else if (event is Submitted) {
      yield* _mapSubmittedToState(
        childName: event.childName,
        dob: event.dob,
        childGender: event.childGender,
      );
    } else if (event is GetChildren) {
      yield* _mapGetChildrenToState();
    }
  }

  Stream<ManagechildrenState> _mapChildNameChangedToState(
      String childName) async* {
    yield state.update(isChildNameValid: Validators.isNameValid(childName));
  }

  Stream<ManagechildrenState> _mapChildAgeChangedToState(String dob) async* {
    yield state.update(isDOBValid: Validators.isDOBValid(dob));
  }

  Stream<ManagechildrenState> _mapGetChildrenToState() async* {
    yield state.update(isLoadingchildren: true);
    try {
      List<Child> children = await _userRepository.getChildren();
      yield state.update(childrenList: children);
    } catch (e) {}
  }

  Stream<ManagechildrenState> _mapSubmittedToState({
    String childName,
    String dob,
    String childGender,
  }) async* {
    yield ManagechildrenState.loading();
    try {
      List<Child> childrenList = await _userRepository.addChild(
          name: childName, dob: dob, gender: childGender);
      yield ManagechildrenState.success(childrenList: childrenList);
    } catch (e) {
      print(e);
      yield ManagechildrenState.failure(errorMsg: e.toString());
    }
  }
}
