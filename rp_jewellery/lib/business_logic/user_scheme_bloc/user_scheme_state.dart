part of 'user_scheme_bloc.dart';

@immutable
sealed class UserSchemeState {}

final class UserSchemeInitial extends UserSchemeState {}

final class UserSchemeLoading extends UserSchemeState {}

final class UserSchemeSucess extends UserSchemeState {
  final UserSchemeModel data;

  UserSchemeSucess({required this.data});
}

final class UserSchemeFailure extends UserSchemeState {}
