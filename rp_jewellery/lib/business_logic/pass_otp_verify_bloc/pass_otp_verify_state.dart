part of 'pass_otp_verify_bloc.dart';

@immutable
sealed class PassOtpVerifyState {}

final class PassOtpVerifyInitial extends PassOtpVerifyState {}

final class PassOtpVerifyLoading extends PassOtpVerifyState {}

final class PassOtpVerifySucess extends PassOtpVerifyState {
  final VerifyOtpModel data;

  PassOtpVerifySucess({required this.data});
}

final class PassOtpVerifyFailure extends PassOtpVerifyState {
  final ErrorModel data;

  PassOtpVerifyFailure({required this.data});
}
