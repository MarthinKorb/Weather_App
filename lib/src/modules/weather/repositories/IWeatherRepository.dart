import 'package:geolocator/geolocator.dart';
import 'package:weather_app/src/modules/weather/infra/model/weather_response.dart';
import 'package:weather_app/src/modules/weather/infra/model/weather_response2.dart';

abstract class IWeatherRepository {
  Future<WeatherResponse> findByCity(String city);
  Future<WeatherResponse2> findByPosition(Position position);
}
