part of 'product_category_bloc.dart';

@immutable
sealed class ProductCategoryEvent {}

class GetCategories extends ProductCategoryEvent {}
