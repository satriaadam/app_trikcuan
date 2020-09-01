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

class BuyRecomendationToday extends RecomendationEvent {
  final String type;

  const BuyRecomendationToday({
    @required this.type
  });

  @override
  List<Object> get props => [type];
}