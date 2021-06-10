import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

abstract class IWebRepository {
  Future<Response> getWeather(String url);
  Future<Response> getWeatherByPosition(Position position);
}
