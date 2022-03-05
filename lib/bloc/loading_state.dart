part of 'loading_bloc.dart';

@immutable
abstract class LoadingState {
  const LoadingState();
  @override
  List<Object?> get props => [];
}

class LoadingInitial extends LoadingState {}

class LoadingError extends LoadingState {
  final String errorMsg;

  const LoadingError({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}

class LoadingSuccess extends LoadingState {
  final Phrase phrase;
  final DateTime datetime;
  final String country;
  final String background;
  final Map<String, String> countries;

  const LoadingSuccess(
      {required this.phrase,
      required this.datetime,
      required this.country,
      required this.countries,
      required this.background});
  @override
  List<Object?> get props => [phrase, datetime, country, countries, background];
}
