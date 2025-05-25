part of 'gold_price_bloc.dart';

@immutable
sealed class GoldPriceState {}

final class GoldPriceInitial extends GoldPriceState {}

final class GoldPriceLoading extends GoldPriceState {}

final class GoldPriceSuccess extends GoldPriceState {
  final String price;

  GoldPriceSuccess({required this.price});
}

final class GoldPriceFailure extends GoldPriceState {}
