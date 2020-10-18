import 'package:equatable/equatable.dart';

abstract class BalanceTopupEvent extends Equatable {
  const BalanceTopupEvent();

  @override
  List<Object> get props => [];
}

class GetData extends BalanceTopupEvent {
  final int page;
  final int limit;
  final bool isRefresh;
  final bool isLoadMore;

  const GetData({
    this.page,
    this.limit,
    this.isRefresh = false,
    this.isLoadMore = false,
  });

  @override
  List<Object> get props => [page, limit, isRefresh, isLoadMore];
}

class VerifyTopup extends BalanceTopupEvent {
  final int id;

  const VerifyTopup({
    this.id
  });

  @override
  List<Object> get props => [id];
}