import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:trikcuan_app/core/model/topup_model.dart';

abstract class BalanceTopupState extends Equatable {
  const BalanceTopupState();
  @override
  List<Object> get props => [];
}

class BalanceTopUpUninitialized extends BalanceTopupState {}

class BalanceTopUpLoading extends BalanceTopupState {}

class BalanceTopUpLoaded extends BalanceTopupState {
  final List<TopupModel> data;
  final bool hasReachedMax;

  const BalanceTopUpLoaded({
    @required this.data,
    this.hasReachedMax
  });

  BalanceTopUpLoaded copyWith({
    List<TopupModel> data,
    bool hasReachedMax,
  }) {
    return BalanceTopUpLoaded(
      data: data ?? this.data,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [data];
}

class TopupVerified extends BalanceTopupState {
  final TopupModel data;

  const TopupVerified({@required this.data});

  @override
  List<Object> get props => [data];
}

class BalanceTopUpFailure extends BalanceTopupState {
  final String error;

  const BalanceTopUpFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
