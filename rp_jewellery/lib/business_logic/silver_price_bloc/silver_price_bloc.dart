import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rp_jewellery/repository/repository.dart';

part 'silver_price_event.dart';
part 'silver_price_state.dart';

class SilverPriceBloc extends Bloc<SilverPriceEvent, SilverPriceState> {
  final Repository repo;

  SilverPriceBloc(this.repo) : super(SilverPriceInitial()) {
    on<GetSilverPriceEvent>((event, emit) async {
      emit(SilverPriceLoading());
      final data = await repo.getSilverPrice();
      emit(SilverPriceSucess(price: data));
    });
  }
}
