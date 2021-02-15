import 'package:equatable/equatable.dart';

abstract class AdminUserEvent extends Equatable {
  const AdminUserEvent();

  @override
  List<Object> get props => [];
}

class AdminLoadUsers extends AdminUserEvent {
  final int page;
  final int limit;
  final String search;
  final bool isRefresh;
  final bool isLoadMore;

  const AdminLoadUsers({
    this.page,
    this.limit,
    this.search,
    this.isRefresh = false,
    this.isLoadMore = false,
  });

  @override
  List<Object> get props => [page, limit, search, isRefresh, isLoadMore];
}