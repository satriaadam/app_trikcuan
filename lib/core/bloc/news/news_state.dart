import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:trikcuan_app/core/model/news_model.dart';

abstract class NewsState extends Equatable {
  const NewsState();
  @override
  List<Object> get props => [];
}

class NewsUninitialized extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<NewsModel> data;

  const NewsLoaded({@required this.data});

  @override
  List<Object> get props => [data];
}

class NewsFailure extends NewsState {
  final String error;

  const NewsFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
