import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/shared/utils/app_images.dart';

import 'package:weather_app/src/modules/weather/infra/model/weather_response.dart';

class WeatherWidget extends StatelessWidget {
  final WeatherResponse weather;

  const WeatherWidget({@required this.weather, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${weather.name} - ${weather.sys.country}',
                style:
                    GoogleFonts.abel(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Lat. ${weather.coord.lat}',
                    style: GoogleFonts.abel(fontSize: 16),
                  ),
                  SizedBox(width: 4),
                  Text(
                    '|',
                    style: GoogleFonts.abel(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Long. ${weather.coord.lon}',
                    style: GoogleFonts.abel(fontSize: 16),
                  ),
                ],
              ),
              Container(
                child: Column(
                  children: [
                    Image.network(
                      'http://openweathermap.org/img/w/${weather.weather.first.icon}.png',
                      height: 70,
                      fit: BoxFit.fill,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${convertKelvinToCelsius(weather.main.temp)}°C',
                          style: GoogleFonts.abel(fontSize: 32),
                        ),
                        Container(
                          margin: const EdgeInsets.all(20),
                          width: 2,
                          height: 50,
                          color: Colors.deepPurple,
                        ),
                        Column(
                          children: [
                            Text(
                              'min.${convertKelvinToCelsius(weather.main.tempMin)}°C',
                              style: GoogleFonts.abel(fontSize: 22),
                            ),
                            Text(
                              'max.${convertKelvinToCelsius(weather.main.tempMax)}°C',
                              style: GoogleFonts.abel(fontSize: 22),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildRoundedContainer(
                            '${weather.wind.speed.toString()} m/s',
                            AppImages.WIND,
                          ),
                          SizedBox(width: 8),
                          _buildRoundedContainer(
                            '${weather.main.humidity}%',
                            AppImages.HUMIDITY,
                          ),
                          SizedBox(width: 8),
                          _buildRoundedContainer(
                            weather.wind.speed.toString(),
                            AppImages.WIND,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String convertKelvinToCelsius(double kelvin) {
    if (kelvin == null) {
      return '-';
    }
    return (kelvin - 273.15).floor().toStringAsFixed(0).toString();
  }

  Container _buildRoundedContainer(String text, String imagePath) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.black12,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(imagePath, height: 28),
          SizedBox(height: 4),
          Text(
            text ?? '-',
            style: GoogleFonts.abel(fontSize: 14),
          )
        ],
      ),
    );
  }
}
