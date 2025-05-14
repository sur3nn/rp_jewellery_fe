part of 'forgot_pass_bloc.dart';

@immutable
sealed class ForgotPassState {}

final class ForgotPassInitial extends ForgotPassState {}

final class ForgotPassLoading extends ForgotPassState {}

final class ForgotPassSucess extends ForgotPassState {
  final LoginModel data;

  ForgotPassSucess({required this.data});
}

final class ForgotPassFailure extends ForgotPassState {
  final ErrorModel data;

  ForgotPassFailure({required this.data});
}
