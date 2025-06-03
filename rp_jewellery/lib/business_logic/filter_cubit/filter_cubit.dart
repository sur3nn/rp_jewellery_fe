import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rp_jewellery/screens/bottom_navigation/bottom_navigation.dart';

class FilterCubit extends Cubit<SortOption> {
  FilterCubit() : super(SortOption.defaultPrice);

  setData(SortOption data) {
    emit(data);
  }
}
