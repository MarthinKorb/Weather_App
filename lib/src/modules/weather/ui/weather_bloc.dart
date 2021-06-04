import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:geolocator/geolocator.dart';
import 'package:weather_app/shared/constants.dart';
import 'package:weather_app/src/modules/weather/infra/model/weather_response.dart';
import 'package:weather_app/src/modules/weather/infra/repositories/weather_repository.dart';
import 'package:weather_app/src/modules/weather/repositories/IWeatherRepository.dart';

class WeatherBloc {
  IWeatherRepository _weatherRepository;

  WeatherBloc({IWeatherRepository weatherRepository}) {
    this._weatherRepository = WeatherRepository();
  }
  StreamController<String> _streamController = StreamController.broadcast();

  Sink<String> get inputCity => _streamController.sink;

  Stream<WeatherResponse> get outputByCity =>
      _streamController.stream.asyncMap((city) => _getWeatherByCity(city));

  Future<WeatherResponse> _getWeatherByCity(String city) async {
    return await this._weatherRepository.findByCity(city);
  }

  StreamController<Position> _positionStreamController =
      StreamController.broadcast();

  Sink<Position> get inputLatLong => _positionStreamController.sink;

  Stream<WeatherResponse> get outputPosition => _positionStreamController.stream
      .asyncMap((position) => _getWeatherByLatLong(position));

  String _url(Position position) =>
      'https://api.openweathermap.org/data/2.5/find?lat=${position.latitude}&lon=${position.longitude}&cnt=10&appid=$API_KEY';

  Future<WeatherResponse> _getWeatherByLatLong(Position position) async {
    final response = await http.get(Uri.parse(_url(position)));
    return WeatherResponse.fromJson(response.body);
  }
}

// api.openweathermap.org/data/2.5/find?lat=55.5&lon=37.5&cnt=10&appid={API key}
