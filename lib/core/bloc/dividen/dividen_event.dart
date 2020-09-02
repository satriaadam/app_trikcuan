import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class DividenEvent extends Equatable {
  const DividenEvent();

  @override
  List<Object> get props => [];
}

class LoadDividenPrice extends DividenEvent {}

class LoadDividenToday extends DividenEvent {}

class LoadDividen extends DividenEvent {
  final String type;

  const LoadDividen({
    @required this.type
  });

  @override
  List<Object> get props => [type];
}

class BuyDividenToday extends DividenEvent {
  final String type;

  const BuyDividenToday({
    @required this.type
  });

  @override
  List<Object> get props => [type];
}