import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/src/modules/weather/infra/model/weather_response.dart';
import 'package:weather_app/src/modules/weather/infra/model/weather_response2.dart';
import 'package:weather_app/src/modules/weather/infra/repositories/weather_repository.dart';
import 'package:weather_app/src/modules/weather/repositories/IWeatherRepository.dart';

class WeatherBloc {
  IWeatherRepository _weatherRepository;

  WeatherBloc({IWeatherRepository weatherRepository}) {
    this._weatherRepository = weatherRepository ?? WeatherRepository();
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

  Stream<WeatherResponse2> get outputPosition =>
      _positionStreamController.stream
          .asyncMap((position) => _getWeatherByLatLong(position));

  Future<WeatherResponse2> _getWeatherByLatLong(Position position) async {
    return await _weatherRepository.findByPosition(position);
  }
}
