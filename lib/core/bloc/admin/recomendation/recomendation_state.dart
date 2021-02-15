import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:trikcuan_app/core/model/recomendation_model.dart';

abstract class AdminRecomendationState extends Equatable {
  const AdminRecomendationState();
  @override
  List<Object> get props => [];
}

class RecomendationUninitialized extends AdminRecomendationState {}

class RecomendationLoading extends AdminRecomendationState {}

class RecomendationLoaded extends AdminRecomendationState {
  final List<RecomendationModel> data;

  const RecomendationLoaded({@required this.data});

  @override
  List<Object> get props => [data];
}

class RecomendationCreated extends AdminRecomendationState {
  final RecomendationModel data;

  const RecomendationCreated({@required this.data});

  @override
  List<Object> get props => [data];
}

class RecomendationUpdated extends AdminRecomendationState {
  final RecomendationModel data;

  const RecomendationUpdated({@required this.data});

  @override
  List<Object> get props => [data];
}

class RecomendationDeleted extends AdminRecomendationState {
  final int id;

  const RecomendationDeleted({@required this.id});

  @override
  List<Object> get props => [id];
}

class RecomendationFailure extends AdminRecomendationState {
  final String error;

  const RecomendationFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
