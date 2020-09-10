import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:trikcuan_app/core/model/sahamlq45_model.dart';
import 'package:trikcuan_app/core/model/sahamlq45_price_model.dart';
import 'package:trikcuan_app/core/model/sahamlq45_today.dart';

abstract class SahamLQ45State extends Equatable {
  const SahamLQ45State();
  @override
  List<Object> get props => [];
}

class SahamLQ45Uninitialized extends SahamLQ45State {}

class SahamLQ45Loading extends SahamLQ45State {}

class SahamLQ45DataAvailable extends SahamLQ45State {}

class SahamLQ45PriceLoaded extends SahamLQ45State {
  final List<SahamLQ45PriceModel> data;

  const SahamLQ45PriceLoaded({@required this.data});

  @override
  List<Object> get props => [data];
}

class SahamLQ45TodayLoaded extends SahamLQ45State {
  final List<SahamLQ45TodayModel> data;

  const SahamLQ45TodayLoaded({@required this.data});

  @override
  List<Object> get props => [data];
}

class SahamLQ45TradingLoaded extends SahamLQ45State {
  final List<SahamLQ45Model> data;

  const SahamLQ45TradingLoaded({@required this.data});

  @override
  List<Object> get props => [data];
}

class SahamLQ45Failure extends SahamLQ45State {
  final String error;

  const SahamLQ45Failure({@required this.error});

  @override
  List<Object> get props => [error];
}
