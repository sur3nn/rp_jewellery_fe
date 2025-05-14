part of 'signup_bloc.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSucess extends SignupState {
  final SignupModel data;

  SignupSucess({required this.data});
}

class SignupFailure extends SignupState {
  final ErrorModel error;

  SignupFailure({required this.error});
}
