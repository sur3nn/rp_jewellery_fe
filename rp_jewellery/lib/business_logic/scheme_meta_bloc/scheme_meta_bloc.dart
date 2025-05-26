import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rp_jewellery/model/scheme_list_model.dart';
import 'package:rp_jewellery/repository/repository.dart';

part 'scheme_meta_event.dart';
part 'scheme_meta_state.dart';

class SchemeMetaBloc extends Bloc<SchemeMetaEvent, SchemeMetaState> {
  final Repository repo;
  SchemeMetaBloc(this.repo) : super(SchemeMetaInitial()) {
    on<StartSchemeMeta>((event, emit) async {
      try {
        emit(SchemeMetaLoading());
        final data = await repo.getSchemes();
        emit(SchemeMetaSucess(data: data));
      } catch (e) {
        emit(SchemeMetaFailure());
      }
    });
  }
}
