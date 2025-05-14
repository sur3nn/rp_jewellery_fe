part of 'user_otp_verify_bloc.dart';

@immutable
sealed class UserOtpVerifyState {}

final class UserOtpVerifyInitial extends UserOtpVerifyState {}

final class UserOtpVerifyLoading extends UserOtpVerifyState {}

final class UserOtpVerifySucess extends UserOtpVerifyState {
  final VerifyOtpModel data;

  UserOtpVerifySucess({required this.data});
}

final class UserOtpVerifyFailure extends UserOtpVerifyState {
  final ErrorModel data;

  UserOtpVerifyFailure({required this.data});
}
