part of 'product_category_bloc.dart';

@immutable
sealed class ProductCategoryState {}

final class ProductCategoryInitial extends ProductCategoryState {}

final class ProductCategoryLoading extends ProductCategoryState {}

final class ProductCategorySuccess extends ProductCategoryState {
  final ProductCategoryModel data;

  ProductCategorySuccess({required this.data});
}

final class ProductCategoryFailure extends ProductCategoryState {}
