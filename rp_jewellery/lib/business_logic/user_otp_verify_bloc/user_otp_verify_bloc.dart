import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rp_jewellery/model/error_model.dart';
import 'package:rp_jewellery/model/verify_otp_model.dart';
import 'package:rp_jewellery/repository/repository.dart';

part 'user_otp_verify_event.dart';
part 'user_otp_verify_state.dart';

class UserOtpVerifyBloc extends Bloc<UserOtpVerifyEvent, UserOtpVerifyState> {
  final Repository repo;
  UserOtpVerifyBloc(this.repo) : super(UserOtpVerifyInitial()) {
    on<VerifyOtp>((event, emit) async {
      try {
        emit(UserOtpVerifyLoading());
        final VerifyOtpModel data =
            await repo.verifyUserOtp(event.email, event.otp);
        emit(UserOtpVerifySucess(data: data));
      } on DioException catch (e) {
        final ErrorModel error = ErrorModel.fromJson(e.response?.data);
        emit(UserOtpVerifyFailure(data: error));
      }
    });
  }
}
