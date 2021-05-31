import 'package:weather_app/shared/WebService/infra/repositories/web_repository.dart';
import 'package:weather_app/shared/WebService/repositories/IWebRepository.dart';
import 'package:weather_app/src/modules/weather/infra/model/weather_response.dart';
import 'package:weather_app/src/modules/weather/repositories/IWeatherRepository.dart';

class WeatherRepository extends IWeatherRepository {
  IWebRepository _webRepository;

  WeatherRepository({IWebRepository webRepository}) {
    _webRepository = WebRepository();
  }

  @override
  Future<WeatherResponse> find(String city) async {
    return await _webRepository.getWeather(city);
  }
}
