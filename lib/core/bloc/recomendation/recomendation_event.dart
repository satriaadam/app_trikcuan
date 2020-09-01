import 'package:equatable/equatable.dart';

abstract class RecomendationEvent extends Equatable {
  const RecomendationEvent();

  @override
  List<Object> get props => [];
}

class LoadRecomendationTrading extends RecomendationEvent {}
class LoadRecomendationSwing extends RecomendationEvent {}
class LoadRecomendationInvest extends RecomendationEvent {}