import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rp_jewellery/model/my_order_model.dart';
import 'package:rp_jewellery/repository/repository.dart';

part 'admin_order_event.dart';
part 'admin_order_state.dart';

class AdminOrderBloc extends Bloc<AdminOrderEvent, AdminOrderState> {
  final Repository repo;
  AdminOrderBloc(this.repo) : super(AdminOrderInitial()) {
    on<GetAdminOrders>((event, emit) async {
      try {
        emit(AdminOrderLoading());
        final data = await repo.orderList(0);
        emit(AdminOrderSucess(data: data));
      } catch (e) {
        emit(AdminOrderFailuire());
      }
    });
  }
}
