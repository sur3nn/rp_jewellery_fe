part of 'all_products_bloc.dart';

@immutable
sealed class AllProductsEvent {}

class StartGetProducts extends AllProductsEvent {
  final int id;
  final String? filter;
  StartGetProducts({
    required this.id,
    this.filter,
  });
}
