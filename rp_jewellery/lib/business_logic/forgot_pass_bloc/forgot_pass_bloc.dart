import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rp_jewellery/model/error_model.dart';
import 'package:rp_jewellery/model/login_model.dart';
import 'package:rp_jewellery/repository/repository.dart';

part 'forgot_pass_event.dart';
part 'forgot_pass_state.dart';

class ForgotPassBloc extends Bloc<ForgotPassEvent, ForgotPassState> {
  final Repository repo;
  ForgotPassBloc(this.repo) : super(ForgotPassInitial()) {
    on<SendMailEvent>((event, emit) async {
      try {
        emit(ForgotPassLoading());
        final LoginModel data = await repo.forgotPass(event.email);
        emit(ForgotPassSucess(data: data));
      } on DioException catch (e) {
        final ErrorModel error = ErrorModel.fromJson(e.response?.data);
        emit(ForgotPassFailure(data: error));
      }
    });
  }
}
