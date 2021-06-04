import 'package:http/http.dart';

abstract class IWebRepository {
  Future<Response> getWeather(String url);
}
