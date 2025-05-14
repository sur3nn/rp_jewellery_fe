import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rp_jewellery/model/error_model.dart';
import 'package:rp_jewellery/model/signup_model.dart';
import 'package:rp_jewellery/repository/repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final Repository repo;
  SignupBloc(this.repo) : super(SignupInitial()) {
    on<StartSignup>((event, emit) async {
      try {
        emit(SignupLoading());
        final SignupModel data =
            await repo.signup(event.name, event.email, event.pass);
        emit(SignupSucess(data: data));
      } on DioException catch (e) {
        final ErrorModel error = ErrorModel.fromJson(e.response?.data);
        emit(SignupFailure(error: error));
      }
    });
  }
}
