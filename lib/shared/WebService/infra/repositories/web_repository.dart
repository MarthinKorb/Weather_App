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
}
