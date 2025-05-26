import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rp_jewellery/model/user_scheme_model.dart';
import 'package:rp_jewellery/repository/repository.dart';

part 'user_scheme_event.dart';
part 'user_scheme_state.dart';

class UserSchemeBloc extends Bloc<UserSchemeEvent, UserSchemeState> {
  final Repository repo;
  UserSchemeBloc(this.repo) : super(UserSchemeInitial()) {
    on<UserSchemeEvent>((event, emit) async {
      try {
        emit(UserSchemeLoading());
        final data = await repo.getUserSchemes();
        emit(UserSchemeSucess(data: data));
      } catch (e) {
        emit(UserSchemeFailure());
      }
    });
  }
}
