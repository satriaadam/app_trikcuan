import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class MarketEvent extends Equatable {
  const MarketEvent();

  @override
  List<Object> get props => [];
}

class LoadMarketPrice extends MarketEvent {}

class LoadMarketToday extends MarketEvent {}

class LoadMarket extends MarketEvent {
  final String type;

  const LoadMarket({
    @required this.type
  });

  @override
  List<Object> get props => [type];
}

class BuyMarketToday extends MarketEvent {
  final String type;

  const BuyMarketToday({
    @required this.type
  });

  @override
  List<Object> get props => [type];
}