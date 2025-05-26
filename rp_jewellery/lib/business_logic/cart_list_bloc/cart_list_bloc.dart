import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rp_jewellery/model/cart_list_model.dart';
import 'package:rp_jewellery/repository/repository.dart';

part 'cart_list_event.dart';
part 'cart_list_state.dart';

class CartListBloc extends Bloc<CartListEvent, CartListState> {
  final Repository repo;
  CartListBloc(this.repo) : super(CartListInitial()) {
    on<StartCartList>((event, emit) async {
      try {
        emit(CartListLoading());
        final data = await repo.cartList();
        emit(CartListSuccess(data: data));
      } catch (e) {
        emit(CartListFailure());
      }
    });
  }
}
