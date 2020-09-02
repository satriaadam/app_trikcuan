import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:trikcuan_app/core/model/dividen_model.dart';

abstract class DividenState extends Equatable {
  const DividenState();
  @override
  List<Object> get props => [];
}

class DividenUninitialized extends DividenState {}

class DividenLoading extends DividenState {}

class DividensLoaded extends DividenState {
  final List<DividenModel> data;

  const DividensLoaded({@required this.data});

  @override
  List<Object> get props => [data];
}

class DividenFailure extends DividenState {
  final String error;

  const DividenFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
