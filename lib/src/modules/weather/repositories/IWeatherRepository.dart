import 'package:weather_app/src/modules/weather/infra/model/weather_response.dart';

abstract class IWeatherRepository {
  Future<WeatherResponse> findByCity(String city);
}
