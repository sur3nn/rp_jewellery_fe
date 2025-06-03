import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rp_jewellery/model/all_product_model.dart';
import 'package:rp_jewellery/repository/repository.dart';

part 'all_products_event.dart';
part 'all_products_state.dart';

class AllProductsBloc extends Bloc<AllProductsEvent, AllProductsState> {
  final Repository repo;
  AllProductsBloc(this.repo) : super(AllProductsInitial()) {
    on<StartGetProducts>((event, emit) async {
      try {
        emit(AllProductsLoading());
        final data = await repo.getAllProducts(event.id, event.filter);
        emit(AllProductsSuccess(data: data));
      } catch (e) {}
    });
  }
}
