import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class SahamLQ45Event extends Equatable {
  const SahamLQ45Event();

  @override
  List<Object> get props => [];
}

class LoadSahamLQ45Price extends SahamLQ45Event {}

class LoadSahamLQ45Today extends SahamLQ45Event {}

class LoadSahamLQ45 extends SahamLQ45Event {
  final String type;

  const LoadSahamLQ45({
    @required this.type
  });

  @override
  List<Object> get props => [type];
}

class CheckSahamLQ45Data extends SahamLQ45Event {
  final String dataId;
  final String sahamlq45;
  final String date;

  const CheckSahamLQ45Data({
    @required this.dataId,
    @required this.sahamlq45,
    @required this.date,
  });

  @override
  List<Object> get props => [dataId, sahamlq45, date];
}

class BuySahamLQ45 extends SahamLQ45Event {
  final String sahamlq45;
  final String type;
  final String dataId;
  final int price;

  const BuySahamLQ45({
    @required this.sahamlq45,
    @required this.type,
    this.dataId,
    this.price,
  });

  @override
  List<Object> get props => [sahamlq45, type, dataId, price];
}