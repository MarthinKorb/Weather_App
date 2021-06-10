import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/shared/utils/utils.dart';
import 'package:weather_app/src/modules/weather/infra/model/weather_response2.dart';

class AroundCitiesWidget extends StatelessWidget {
  final WeatherResponse2 weather;

  const AroundCitiesWidget({@required this.weather, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: weather.list.length,
        itemBuilder: (context, index) {
          return Card(
            child: Container(
              child: ListTile(
                title: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          weather.list[index]["name"],
                          style: GoogleFonts.abel(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Sensação térmica: ${Utils.convertKelvinToCelsius(
                            weather.list[index]["main"]["feels_like"],
                          )}',
                          style: GoogleFonts.abel(fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(''),
                        Column(
                          children: [
                            Text(
                              'Temp. mínima: ${Utils.convertKelvinToCelsius(
                                weather.list[index]["main"]["temp_min"],
                              )}',
                              style: GoogleFonts.abel(fontSize: 16),
                            ),
                            Text(
                              'Temp. máxima: ${Utils.convertKelvinToCelsius(
                                weather.list[index]["main"]["temp_max"],
                              )}',
                              style: GoogleFonts.abel(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                subtitle: Text(
                  '${weather.list[index]["weather"][0]["description"]} - ${Utils.convertKelvinToCelsius(weather.list[index]["main"]["temp"])}',
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
