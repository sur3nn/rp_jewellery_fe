part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent {}

class StartSignup extends SignupEvent {
  final String name;
  final String email;
  final String pass;

  StartSignup({required this.name, required this.email, required this.pass});
}
