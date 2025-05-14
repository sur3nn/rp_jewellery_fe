part of 'forgot_pass_bloc.dart';

@immutable
sealed class ForgotPassEvent {}

class SendMailEvent extends ForgotPassEvent {
  final String email;

  SendMailEvent({required this.email});
}
