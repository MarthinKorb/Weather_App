import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/shared/WebService/repositories/IWebRepository.dart';
import '../../../constants.dart';

class WebRepository extends IWebRepository {
  String url({String cityName}) =>
      'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$API_KEY';

  @override
  Future<http.Response> getWeather(String cityName) async {
    final _url = url(cityName: cityName.toLowerCase().trim());

    final response = await http.get(Uri.parse(_url));

    if (response.statusCode != 200) {
      throw Exception('Cidade não existe');
    }

    return response;
  }

  String _url(Position position) =>
      'https://api.openweathermap.org/data/2.5/find?lat=${position.latitude}&lon=${position.longitude}&cnt=10&appid=$API_KEY';
  @override
  Future<http.Response> getWeatherByPosition(Position position) async {
    final response = await http.get(Uri.tryParse(_url(position)));

    if (response.statusCode != 200) {
      throw Exception('Erro na consulta de cidades');
    }

    return response;
  }
}
