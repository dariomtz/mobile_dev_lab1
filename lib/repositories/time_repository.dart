import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class TimeRepository {
  Future<DateTime> getTime(String timezone);
}

class HttpTimeRepository with TimeRepository {
  final String uri = "http://worldtimeapi.org/api/timezone/";

  @override
  Future<DateTime> getTime(String timezone) async {
    http.Response response = await http.get(Uri.parse("$uri/$timezone"));
    Map<String, dynamic> json = jsonDecode(response.body);
    return DateTime.fromMicrosecondsSinceEpoch(json['unixtime']);
  }
}
