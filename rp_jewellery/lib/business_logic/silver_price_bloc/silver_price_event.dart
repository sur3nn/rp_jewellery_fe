part of 'silver_price_bloc.dart';

@immutable
sealed class SilverPriceEvent {}

class GetSilverPriceEvent extends SilverPriceEvent {}
