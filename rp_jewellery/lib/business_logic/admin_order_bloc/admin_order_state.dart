part of 'admin_order_bloc.dart';

@immutable
sealed class AdminOrderState {}

final class AdminOrderInitial extends AdminOrderState {}

final class AdminOrderLoading extends AdminOrderState {}

final class AdminOrderSucess extends AdminOrderState {
  final MyOrderModel data;

  AdminOrderSucess({required this.data});
}

final class AdminOrderFailuire extends AdminOrderState {}
