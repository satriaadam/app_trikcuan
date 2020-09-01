import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class RecomendationEvent extends Equatable {
  const RecomendationEvent();

  @override
  List<Object> get props => [];
}

class LoadRecomendation extends RecomendationEvent {
  final String type;

  const LoadRecomendation({
    @required this.type
  });

  @override
  List<Object> get props => [type];
}