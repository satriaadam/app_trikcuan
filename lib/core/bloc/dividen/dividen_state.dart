import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:trikcuan_app/core/model/dividen_model.dart';
import 'package:trikcuan_app/core/model/dividen_price_model.dart';
import 'package:trikcuan_app/core/model/dividen_today.dart';

abstract class DividenState extends Equatable {
  const DividenState();
  @override
  List<Object> get props => [];
}

class DividenUninitialized extends DividenState {}

class DividenLoading extends DividenState {}

class DividenPriceLoaded extends DividenState {
  final List<DividenPriceModel> data;

  const DividenPriceLoaded({@required this.data});

  @override
  List<Object> get props => [data];
}

class DividenTodayLoaded extends DividenState {
  final List<DividenTodayModel> data;

  const DividenTodayLoaded({@required this.data});

  @override
  List<Object> get props => [data];
}

class DividenTradingLoaded extends DividenState {
  final List<DividenModel> data;

  const DividenTradingLoaded({@required this.data});

  @override
  List<Object> get props => [data];
}

class DividenFailure extends DividenState {
  final String error;

  const DividenFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
