part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class StartLogin extends LoginEvent {
  final String email;
  final String pass;

  StartLogin({required this.email, required this.pass});
}
