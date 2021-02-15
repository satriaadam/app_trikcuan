import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:trikcuan_app/core/model/account_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class AuthUninitialized extends AuthState {}

class AuthUnauthenticated extends AuthState {}

class AuthLoading extends AuthState {}

class AuthChecking extends AuthState {}

class AuthAuthenticated extends AuthState {
  final Account data;

  const AuthAuthenticated({@required this.data});

  @override
  List<Object> get props => [data];
}

class AuthLoginSuccess extends AuthState {
  final Account data;

  const AuthLoginSuccess({@required this.data});

  @override
  List<Object> get props => [data];
}

class RegisterSuccess extends AuthState {
  final Account data;

  const RegisterSuccess({@required this.data});

  @override
  List<Object> get props => [data];
}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
