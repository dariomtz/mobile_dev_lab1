import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:mobile_dev_lab1/data/Phrase.dart';
import 'package:mobile_dev_lab1/repositories/phrase_repository.dart';
import 'package:mobile_dev_lab1/repositories/time_repository.dart';

part 'loading_event.dart';
part 'loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  final PhraseRepository phraseRepository = HttpPhraseRepository();
  final TimeRepository timeRepository = HttpTimeRepository();
  final _random = new Random();
  final Map<String, Map<String, String>> countries = {
    'Mexico': {'code': 'mx', 'timezone': 'America/Mexico_City'},
    'Argentina': {'code': 'ar', 'timezone': 'America/Argentina/Buenos_Aires'},
    'Peru': {'code': 'pe', 'timezone': 'America/Lima'},
  };

  int randomInt() => _random.nextInt(1000);

  String getFlagURL(String country) =>
      "https://flagcdn.com/16x12/${countries[country]?['code']}.png";

  String getTimezone(String country) =>
      countries[country]?['timezone'] ?? 'America/Mexico_City';

  String getRandomImage() => 'https://picsum.photos/id/${randomInt()}/400/600';

  LoadingBloc() : super(LoadingInitial()) {
    on<LoadScreenEvent>((event, emit) async {
      try {
        emit(LoadingSuccess(
            background: getRandomImage(),
            phrase: await phraseRepository.getRandomPhrase(),
            datetime: await timeRepository.getTime(getTimezone(event.country)),
            country: event.country,
            countries: {
              for (var country in countries.keys) country: getFlagURL(country)
            }));
      } catch (err) {
        print(err);
        emit(LoadingError(errorMsg: err.toString()));
      }
    });

    on<ChangeCountryEvent>((event, emit) async {
      try {
        emit(LoadingSuccess(
            background: getRandomImage(),
            phrase: await phraseRepository.getRandomPhrase(),
            datetime: await timeRepository.getTime(getTimezone(event.country)),
            country: event.country,
            countries: {
              for (var country in countries.keys) country: getFlagURL(country)
            }));
      } catch (err) {
        print(err);
        emit(LoadingError(errorMsg: err.toString()));
      }
    });
  }
}
