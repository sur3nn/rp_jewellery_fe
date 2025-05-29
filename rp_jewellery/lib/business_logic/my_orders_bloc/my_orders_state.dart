part of 'my_orders_bloc.dart';

@immutable
sealed class MyOrdersState {}

final class MyOrdersInitial extends MyOrdersState {}

final class MyOrdersLoading extends MyOrdersState {}

final class MyOrdersSuccess extends MyOrdersState {
  final MyOrderModel dat;

  MyOrdersSuccess({required this.dat});
}

final class MyOrdersFailure extends MyOrdersState {}
