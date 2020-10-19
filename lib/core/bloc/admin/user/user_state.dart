import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:trikcuan_app/core/model/account_model.dart';

abstract class AdminUserState extends Equatable {
  const AdminUserState();
  @override
  List<Object> get props => [];
}

class AdminUserUninitialized extends AdminUserState {}

class AdminUserLoading extends AdminUserState {}

class AdminUserLoaded extends AdminUserState {
  final List<Account> data;
  final bool hasReachedMax;

  const AdminUserLoaded({
    @required this.data,
    this.hasReachedMax
  });

  AdminUserLoaded copyWith({
    List<Account> data,
    bool hasReachedMax,
  }) {
    return AdminUserLoaded(
      data: data ?? this.data,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [data];
}

class AdminUserFailure extends AdminUserState {
  final String error;

  const AdminUserFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
