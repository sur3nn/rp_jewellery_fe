part of 'gold_price_bloc.dart';

@immutable
sealed class GoldPriceEvent {}

class GetGoldPriceEvent extends GoldPriceEvent {}
