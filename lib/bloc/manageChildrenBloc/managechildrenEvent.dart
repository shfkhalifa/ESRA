import 'package:esra/models/child.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

// abstract class ManagechildrenEvent extends Equatable {
//   const ManagechildrenEvent();
// }

abstract class ManagechildrenEvent extends Equatable {
  const ManagechildrenEvent();

  @override
  List<Object> get props => [];
}

class ChildNameChanged extends ManagechildrenEvent {
  final String childName;

  const ChildNameChanged({@required this.childName});

  @override
  List<Object> get props => [childName];

  @override
  String toString() => 'ChildNameChanged { Child Name :$childName }';
}

class ChildAgeChanged extends ManagechildrenEvent {
  final String dob;

  const ChildAgeChanged({@required this.dob});

  @override
  List<Object> get props => [dob];

  @override
  String toString() => 'ChildAgeChanged { Child DOB: $dob }';
}

class ChildGenderChanged extends ManagechildrenEvent {
  final String childGender;

  const ChildGenderChanged({@required this.childGender});

  @override
  List<Object> get props => [childGender];

  @override
  String toString() => 'ChildGenderChanged { Child Gender: $childGender }';
}

// class ChildrenCountChanged extends ManagechildrenEvent {
//   final List<Child> childrenList;

//   const ChildrenCountChanged({@required this.childrenList});

//   @override
//   List<Object> get props => [childrenList];

//   @override
//   String toString() => 'ChildrenCountChanged { Children List: $childrenList }';
// }

class GetChildren extends ManagechildrenEvent {
  @override
  String toString() => 'GetChildren()';
}

class Submitted extends ManagechildrenEvent {
  final String childName;
  final String dob;
  final String childGender;

  const Submitted({
    @required this.childName,
    @required this.dob,
    @required this.childGender,
  });

  @override
  List<Object> get props => [childName, dob, childGender];

  @override
  String toString() {
    return 'Submitted { childName: $childName, dob: $dob, childGender: $childGender }';
  }
}
