part of 'admin_order_bloc.dart';

@immutable
sealed class AdminOrderEvent {}

class GetAdminOrders extends AdminOrderEvent {}
