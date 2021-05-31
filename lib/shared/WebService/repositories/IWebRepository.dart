import 'package:weather_app/src/modules/weather/infra/model/weather_response.dart';

abstract class IWebRepository {
  Future<WeatherResponse> getWeather(String url);
}
