import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rp_jewellery/model/error_model.dart';
import 'package:rp_jewellery/model/login_model.dart';
import 'package:rp_jewellery/repository/repository.dart';

part 'change_pass_event.dart';
part 'change_pass_state.dart';

class ChangePassBloc extends Bloc<ChangePassEvent, ChangePassState> {
  final Repository repo;
  ChangePassBloc(this.repo) : super(ChangePassInitial()) {
    on<ChangeUserPass>((event, emit) async {
      try {
        emit(ChangePassLoading());
        final LoginModel data = await repo.changePass(event.email, event.pass);
        emit(ChangePassSucess(data: data));
      } on DioException catch (e) {
        final ErrorModel error = ErrorModel.fromJson(e.response?.data);
        emit(ChangePassFailure(data: error));
      }
    });
  }
}
