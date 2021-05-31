import 'package:flutter/cupertino.dart';
import 'package:weather_app/src/modules/weather/infra/model/weather_response.dart';

class WeatherProvider with ChangeNotifier {
  WeatherResponse _data;

  void setWeather(WeatherResponse data) {
    _data = data;
    notifyListeners();
  }

  WeatherResponse get weather => _data;
}
