import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rp_jewellery/model/login_model.dart';
import 'package:rp_jewellery/repository/repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Repository repo;

  LoginBloc(this.repo) : super(LoginInitial()) {
    on<StartLogin>((event, emit) async {
      try {
        emit(LoginLoading());
        final data = await repo.login(event.email, event.password);
        emit(LoginSucess(data: data));
      } catch (e) {
        print(e);
      }
    });
  }
}
