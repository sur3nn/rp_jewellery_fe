part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSucess extends LoginState {
  final LoginModel data;

  LoginSucess({required this.data});
}

final class LoginFailure extends LoginState {}
