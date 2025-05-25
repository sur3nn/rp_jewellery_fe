part of 'all_products_bloc.dart';

@immutable
sealed class AllProductsEvent {}

class StartGetProducts extends AllProductsEvent {
  final int id;

  StartGetProducts({required this.id});
}
