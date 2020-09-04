import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class DividenEvent extends Equatable {
  const DividenEvent();

  @override
  List<Object> get props => [];
}

class LoadDividenPrice extends DividenEvent {}

class LoadDividenToday extends DividenEvent {}

class LoadDividen extends DividenEvent {}

class CheckDividen extends DividenEvent {
  final String dataId;

  const CheckDividen({
    @required this.dataId,
  });

  @override
  List<Object> get props => [ParentDataWidget];
}

class BuyDividen extends DividenEvent {
  final String dataId;
  final int price;

  const BuyDividen({
    this.dataId,
    this.price,
  });

  @override
  List<Object> get props => [dataId, price];
}