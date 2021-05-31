import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/shared/WebService/infra/repositories/web_repository.dart';
import 'package:weather_app/src/modules/weather/infra/model/weather_response.dart';
import 'package:weather_app/src/modules/weather/ui/weather_provider.dart';

class WeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final _formKey = GlobalKey<FormState>();
    String _cityName;
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  style: GoogleFonts.abel(fontSize: 16),
                  keyboardType: TextInputType.multiline,
                  onChanged: (cityName) {
                    _cityName = cityName;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o nome da cidade';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.done),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          final weather =
                              await WebRepository().getWeather(_cityName);

                          weatherProvider.setWeather(weather);
                        }
                      },
                    ),
                    labelText: 'Digite o nome da cidade',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                  ),
                ),
              ),
            ),
            Consumer<WeatherProvider>(
              builder: (context, data, _) {
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Tempo em ${data.weather.name}'),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
