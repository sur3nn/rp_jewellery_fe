import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rp_jewellery/repository/repository.dart';

part 'gold_price_event.dart';
part 'gold_price_state.dart';

class GoldPriceBloc extends Bloc<GoldPriceEvent, GoldPriceState> {
  final Repository repo;
  GoldPriceBloc(this.repo) : super(GoldPriceInitial()) {
    on<GetGoldPriceEvent>((event, emit) async {
      emit(GoldPriceLoading());
      final data = await repo.getGoldPrice();
      emit(GoldPriceSuccess(price: data));
    });
  }
}
