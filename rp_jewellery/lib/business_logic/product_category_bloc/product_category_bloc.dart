import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rp_jewellery/model/product_category_model.dart';
import 'package:rp_jewellery/repository/repository.dart';

part 'product_category_event.dart';
part 'product_category_state.dart';

class ProductCategoryBloc
    extends Bloc<ProductCategoryEvent, ProductCategoryState> {
  final Repository repo;
  ProductCategoryBloc(this.repo) : super(ProductCategoryInitial()) {
    on<ProductCategoryEvent>((event, emit) async {
      try {
        emit(ProductCategoryLoading());
        final data = await repo.getCategories();
        emit(ProductCategorySuccess(data: data));
      } catch (e) {}
    });
  }
}
