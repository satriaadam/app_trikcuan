import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:trikcuan_app/core/model/market_model.dart';
import 'package:trikcuan_app/core/model/market_price_model.dart';
import 'package:trikcuan_app/core/model/market_today.dart';

abstract class MarketState extends Equatable {
  const MarketState();
  @override
  List<Object> get props => [];
}

class MarketUninitialized extends MarketState {}

class MarketLoading extends MarketState {}

class MarketPriceLoaded extends MarketState {
  final List<MarketPriceModel> data;

  const MarketPriceLoaded({@required this.data});

  @override
  List<Object> get props => [data];
}

class MarketTodayLoaded extends MarketState {
  final List<MarketTodayModel> data;

  const MarketTodayLoaded({@required this.data});

  @override
  List<Object> get props => [data];
}

class MarketTradingLoaded extends MarketState {
  final List<MarketModel> data;

  const MarketTradingLoaded({@required this.data});

  @override
  List<Object> get props => [data];
}

class MarketFailure extends MarketState {
  final String error;

  const MarketFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
