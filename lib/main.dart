import 'package:flutter/material.dart';
import 'package:weather_app/src/modules/weather/ui/weather_page.dart';
import 'package:weather_app/src/modules/weather/ui/weather_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: WeatherPage(),
      // home: TesteWidget(),
    );
  }
}
