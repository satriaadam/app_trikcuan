import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:trikcuan_app/core/model/recomendation_model.dart';
import 'package:trikcuan_app/core/model/recomendation_price_model.dart';
import 'package:trikcuan_app/core/model/recomendation_today.dart';

abstract class RecomendationState extends Equatable {
  const RecomendationState();
  @override
  List<Object> get props => [];
}

class RecomendationUninitialized extends RecomendationState {}

class RecomendationLoading extends RecomendationState {}

class RecomendationDataAvailable extends RecomendationState {}

class RecomendationPriceLoaded extends RecomendationState {
  final List<RecomendationPriceModel> data;

  const RecomendationPriceLoaded({@required this.data});

  @override
  List<Object> get props => [data];
}

class RecomendationTodayLoaded extends RecomendationState {
  final List<RecomendationTodayModel> data;

  const RecomendationTodayLoaded({@required this.data});

  @override
  List<Object> get props => [data];
}

class RecomendationTradingLoaded extends RecomendationState {
  final List<RecomendationModel> data;

  const RecomendationTradingLoaded({@required this.data});

  @override
  List<Object> get props => [data];
}

class RecomendationFailure extends RecomendationState {
  final String error;

  const RecomendationFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
