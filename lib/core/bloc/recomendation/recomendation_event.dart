import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class RecomendationEvent extends Equatable {
  const RecomendationEvent();

  @override
  List<Object> get props => [];
}

class LoadRecomendationPrice extends RecomendationEvent {}

class LoadRecomendationToday extends RecomendationEvent {}

class LoadRecomendation extends RecomendationEvent {
  final String type;

  const LoadRecomendation({
    @required this.type
  });

  @override
  List<Object> get props => [type];
}

class CheckRecomendationData extends RecomendationEvent {
  final String dataId;
  final String recomendation;
  final String date;

  const CheckRecomendationData({
    @required this.dataId,
    @required this.recomendation,
    @required this.date,
  });

  @override
  List<Object> get props => [dataId, recomendation, date];
}

class BuyRecomendation extends RecomendationEvent {
  final String recomendation;
  final String type;
  final String dataId;
  final int price;

  const BuyRecomendation({
    @required this.recomendation,
    @required this.type,
    this.dataId,
    this.price,
  });

  @override
  List<Object> get props => [recomendation, type, dataId, price];
}