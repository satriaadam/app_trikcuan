import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:trikcuan_app/core/model/account_model.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class Login extends AuthEvent {
  final String username;
  final String password;

  const Login({
    @required this.username,
    @required this.password,
  });

  @override
  List<Object> get props => [username, password];
}

class Register extends AuthEvent {
  final RegisterAccount data;

  const Register({
    @required this.data
  });

  @override
  List<Object> get props => [data];
}

class Logout extends AuthEvent {}