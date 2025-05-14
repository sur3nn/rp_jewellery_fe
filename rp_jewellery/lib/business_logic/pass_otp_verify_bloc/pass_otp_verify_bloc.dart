import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rp_jewellery/model/error_model.dart';
import 'package:rp_jewellery/model/verify_otp_model.dart';
import 'package:rp_jewellery/repository/repository.dart';

part 'pass_otp_verify_event.dart';
part 'pass_otp_verify_state.dart';

class PassOtpVerifyBloc extends Bloc<PassOtpVerifyEvent, PassOtpVerifyState> {
  final Repository repo;
  PassOtpVerifyBloc(this.repo) : super(PassOtpVerifyInitial()) {
    on<VerifyPassOtp>((event, emit) async {
      try {
        emit(PassOtpVerifyLoading());
        final VerifyOtpModel data =
            await repo.verifyPassOtp(event.email, event.otp);
        emit(PassOtpVerifySucess(data: data));
      } on DioException catch (e) {
        final ErrorModel error = ErrorModel.fromJson(e.response?.data);
        emit(PassOtpVerifyFailure(data: error));
      }
    });
  }
}
