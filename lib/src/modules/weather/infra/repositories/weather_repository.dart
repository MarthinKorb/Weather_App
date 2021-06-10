import 'package:geolocator/geolocator.dart';
import 'package:weather_app/shared/WebService/infra/repositories/web_repository.dart';
import 'package:weather_app/shared/WebService/repositories/IWebRepository.dart';
import 'package:weather_app/src/modules/weather/infra/model/weather_response.dart';
import 'package:weather_app/src/modules/weather/infra/model/weather_response2.dart';
import 'package:weather_app/src/modules/weather/repositories/IWeatherRepository.dart';

class WeatherRepository extends IWeatherRepository {
  IWebRepository _webRepository;

  WeatherRepository({IWebRepository webRepository}) {
    _webRepository = webRepository ?? WebRepository();
  }

  @override
  Future<WeatherResponse> findByCity(String url) async {
    final response = await _webRepository.getWeather(url);
    return WeatherResponse.fromJson(response.body);
  }

  @override
  Future<WeatherResponse2> findByPosition(Position position) async {
    final response = await _webRepository.getWeatherByPosition(position);
    return WeatherResponse2.fromJson(response.body);
  }
}
