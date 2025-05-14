part of 'change_pass_bloc.dart';

@immutable
sealed class ChangePassEvent {}

class ChangeUserPass extends ChangePassEvent {
  final String email;
  final String pass;

  ChangeUserPass({required this.email, required this.pass});
}
