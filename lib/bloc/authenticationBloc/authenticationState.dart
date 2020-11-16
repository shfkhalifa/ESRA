import 'package:equatable/equatable.dart';
import 'package:esra/models/child.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  // final List<Child> childrenList;

  // const Authenticated(this.childrenList);

  @override
  List<Object> get props => [];

  @override
  String toString() => 'Authenticated ()';
}

class Unauthenticated extends AuthenticationState {}
