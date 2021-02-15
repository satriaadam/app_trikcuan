import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:trikcuan_app/core/model/market_model.dart';

abstract class MarketState extends Equatable {
  const MarketState();
  @override
  List<Object> get props => [];
}

class MarketUninitialized extends MarketState {}

class MarketLoading extends MarketState {}

class MarketLoaded extends MarketState {
  final List<MarketModel> data;

  const MarketLoaded({@required this.data});

  @override
  List<Object> get props => [data];
}

class MarketFailure extends MarketState {
  final String error;

  const MarketFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
