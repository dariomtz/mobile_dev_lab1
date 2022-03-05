part of 'loading_bloc.dart';

@immutable
abstract class LoadingEvent {
  final String country;
  const LoadingEvent({required this.country});
}

class LoadScreenEvent extends LoadingEvent {
  const LoadScreenEvent() : super(country: "Mexico");
}

class ChangeCountryEvent extends LoadingEvent {
  const ChangeCountryEvent({required String country}) : super(country: country);
}
