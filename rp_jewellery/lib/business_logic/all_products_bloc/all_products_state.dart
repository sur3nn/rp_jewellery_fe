part of 'all_products_bloc.dart';

@immutable
sealed class AllProductsState {}

final class AllProductsInitial extends AllProductsState {}

final class AllProductsLoading extends AllProductsState {}

final class AllProductsSuccess extends AllProductsState {
  final ProductDetailsModel data;

  AllProductsSuccess({required this.data});
}

final class AllProductsFailure extends AllProductsState {}
