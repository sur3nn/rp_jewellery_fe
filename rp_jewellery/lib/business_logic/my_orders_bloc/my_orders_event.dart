part of 'my_orders_bloc.dart';

@immutable
sealed class MyOrdersEvent {}

class StartOrders extends MyOrdersEvent {}
