part of 'scheme_meta_bloc.dart';

@immutable
sealed class SchemeMetaState {}

final class SchemeMetaInitial extends SchemeMetaState {}

final class SchemeMetaLoading extends SchemeMetaState {}

final class SchemeMetaSucess extends SchemeMetaState {
  final SchemeListModel data;

  SchemeMetaSucess({required this.data});
}

final class SchemeMetaFailure extends SchemeMetaState {}
