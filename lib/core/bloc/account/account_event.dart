import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:trikcuan_app/core/model/account_model.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class GetAccount extends AccountEvent {}

class BuyConsultation extends AccountEvent {}

class BuyLiveTrading extends AccountEvent {}

class UpdateEmail extends AccountEvent {
  final String email;

  const UpdateEmail({
    @required this.email
  });

  @override
  List<Object> get props => [email];
}

class EditProfile extends AccountEvent {
  final RegisterAccount data;

  const EditProfile({
    @required this.data
  });

  @override
  List<Object> get props => [data];
}

class RequestTopupSaldo extends AccountEvent {
  final int saldo;

  const RequestTopupSaldo({
    @required this.saldo
  });

  @override
  List<Object> get props => [saldo];
}