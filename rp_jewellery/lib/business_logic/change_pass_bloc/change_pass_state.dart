part of 'change_pass_bloc.dart';

@immutable
sealed class ChangePassState {}

final class ChangePassInitial extends ChangePassState {}

final class ChangePassLoading extends ChangePassState {}

final class ChangePassSucess extends ChangePassState {
  final LoginModel data;

  ChangePassSucess({required this.data});
}

final class ChangePassFailure extends ChangePassState {
  final ErrorModel data;

  ChangePassFailure({required this.data});
}
