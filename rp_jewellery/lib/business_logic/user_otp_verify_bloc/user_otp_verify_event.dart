part of 'user_otp_verify_bloc.dart';

@immutable
sealed class UserOtpVerifyEvent {}

class VerifyOtp extends UserOtpVerifyEvent {
  final String email;
  final String otp;

  VerifyOtp({required this.email, required this.otp});
}
