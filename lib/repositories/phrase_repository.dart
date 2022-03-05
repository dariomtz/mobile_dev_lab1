import 'dart:convert';

import 'package:mobile_dev_lab1/data/Phrase.dart';
import 'package:http/http.dart' as http;

abstract class PhraseRepository {
  Future<Phrase> getRandomPhrase();
}

class HttpPhraseRepository with PhraseRepository {
  final String uri = "https://zenquotes.io/api/random";

  @override
  Future<Phrase> getRandomPhrase() async {
    http.Response response = await http.get(Uri.parse(uri));
    List<dynamic> json = jsonDecode(response.body);
    return Phrase.fromJson(json[0]);
  }
}
