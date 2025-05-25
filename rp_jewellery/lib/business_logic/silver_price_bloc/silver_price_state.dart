part of 'silver_price_bloc.dart';

@immutable
sealed class SilverPriceState {}

final class SilverPriceInitial extends SilverPriceState {}

final class SilverPriceLoading extends SilverPriceState {}

final class SilverPriceSucess extends SilverPriceState {
  final String price;

  SilverPriceSucess({required this.price});
}

final class SilverPriceFailure extends SilverPriceState {}
