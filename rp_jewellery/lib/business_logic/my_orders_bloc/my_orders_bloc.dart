import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rp_jewellery/model/my_order_model.dart';
import 'package:rp_jewellery/repository/repository.dart';

part 'my_orders_event.dart';
part 'my_orders_state.dart';

class MyOrdersBloc extends Bloc<MyOrdersEvent, MyOrdersState> {
  final Repository repo;
  MyOrdersBloc(this.repo) : super(MyOrdersInitial()) {
    on<StartOrders>((event, emit) async {
      try {
        emit(MyOrdersLoading());

        final data = await repo.orderList();
        emit(MyOrdersSuccess(dat: data));
      } catch (e) {
        emit(MyOrdersFailure());
      }
    });
  }
}
