part of 'cart_list_bloc.dart';

@immutable
sealed class CartListState {}

final class CartListInitial extends CartListState {}

final class CartListLoading extends CartListState {}

final class CartListSuccess extends CartListState {
  final CartListModel data;

  CartListSuccess({required this.data});
}

final class CartListFailure extends CartListState {}
