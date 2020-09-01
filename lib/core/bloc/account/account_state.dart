import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:trikcuan_app/core/model/account_model.dart';
import 'package:trikcuan_app/core/model/topup_model.dart';

abstract class AccountState extends Equatable {
  const AccountState();
  @override
  List<Object> get props => [];
}

class AccountUninitialized extends AccountState {}

class AccountLoading extends AccountState {}

class AccountSuccess extends AccountState {
  final Account data;

  const AccountSuccess({@required this.data});

  @override
  List<Object> get props => [data];
}

class UpdateEmailSuccess extends AccountState {
  final Account data;

  const UpdateEmailSuccess({@required this.data});

  @override
  List<Object> get props => [data];
}

class EditProfileSuccess extends AccountState {
  final Account data;

  const EditProfileSuccess({@required this.data});

  @override
  List<Object> get props => [data];
}

class RequestTopupSaldoSuccess extends AccountState {
  final TopupModel data;

  const RequestTopupSaldoSuccess({@required this.data});

  @override
  List<Object> get props => [data];
}

class AccountFailure extends AccountState {
  final String error;

  const AccountFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
