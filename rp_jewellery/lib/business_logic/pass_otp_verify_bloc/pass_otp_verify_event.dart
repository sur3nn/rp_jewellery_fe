part of 'pass_otp_verify_bloc.dart';

@immutable
sealed class PassOtpVerifyEvent {}

class VerifyPassOtp extends PassOtpVerifyEvent {
  final String email;
  final String otp;

  VerifyPassOtp({required this.email, required this.otp});
}
