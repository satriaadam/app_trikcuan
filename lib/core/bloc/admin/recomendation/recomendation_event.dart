import 'package:equatable/equatable.dart';
import 'package:trikcuan_app/core/model/recomendation_model.dart';

abstract class AdminRecomendationEvent extends Equatable {
  const AdminRecomendationEvent();

  @override
  List<Object> get props => [];
}

class LoadRecomendation extends AdminRecomendationEvent {
  final String type;
  final String date;

  const LoadRecomendation({
    this.type,
    this.date
  });

  @override
  List<Object> get props => [type, date];
}

class AddRecomendation extends AdminRecomendationEvent {
  final RecomendationPost data;

  const AddRecomendation({
    this.data
  });

  @override
  List<Object> get props => [data];
}

class EditRecomendation extends AdminRecomendationEvent {
  final String id;
  final RecomendationPost data;

  const EditRecomendation({
    this.id,
    this.data
  });

  @override
  List<Object> get props => [id, data];
}

class DeleteRecomendation extends AdminRecomendationEvent {
  final int id;

  const DeleteRecomendation({
    this.id,
  });

  @override
  List<Object> get props => [id];
}