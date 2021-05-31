import 'package:http/http.dart' as http;
import 'package:weather_app/shared/WebService/repositories/IWebRepository.dart';
import 'package:weather_app/src/modules/weather/infra/model/weather_response.dart';

import '../../../constants.dart';

class WebRepository extends IWebRepository {
  String url({String cityName}) =>
      'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$API_KEY';

  @override
  Future<WeatherResponse> getWeather(String cityName) async {
    final _url = url(cityName: cityName.toLowerCase().trim());
    final response = await http.get(Uri.parse(_url));
    return WeatherResponse.fromJson(response.body);
  }
}
