import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/shared/LocationService/infra/geolocator/repositories/LocationRepository.dart';
import 'package:weather_app/src/modules/weather/infra/model/weather_response.dart';
import 'package:weather_app/src/modules/weather/ui/weather_bloc.dart';
import 'package:weather_app/src/modules/weather/ui/weather_widget.dart';

import 'city_not_found_widget.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherBloc = WeatherBloc();
  @override
  void initState() {
    LocationRepository()
        .determinePosition()
        .then((value) => _weatherBloc.inputLatLong.add(value));
    // .then((value) => print(value));
    Future.delayed(Duration(seconds: 3));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final weatherProvider = Provider.of<WeatherProvider>(context);

    final _formKey = GlobalKey<FormState>();

    String _cityName;

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
          child: Container(
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
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search_outlined),
                    onPressed: () async {
                      // await _handleRequestData(
                      //     _formKey, _cityName, weatherProvider);
                      _weatherBloc.inputCity.add(_cityName);
                    },
                  ),
                  hintText: 'Digite o nome da cidade',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.black12.withOpacity(0.04),
          child: Column(
            children: [
              // Consumer<WeatherProvider>(
              //   builder: (context, snapshot, _) {
              //     if (snapshot.weather == null) {
              //       return Center(
              //         child: Container(
              //           child: Text(''),
              //         ),
              //       );
              //     }
              //     return WeatherWidget(weather: snapshot.weather);
              //   },
              // ),
              StreamBuilder<WeatherResponse>(
                stream: _weatherBloc.outputByCity,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return CityNotFoundWidget();
                  }
                  if (!snapshot.hasData) {
                    return Container(
                        // child: FutureBuilder(
                        //   future: LocationRepository().determinePosition(),
                        //   builder: (context, snapshot) {
                        //     return Center(
                        //       child: Text(snapshot.data.toString()),
                        //     );
                        //   },
                        // ),
                        );
                  }

                  return WeatherWidget(weather: snapshot.data);
                },
              ),
              StreamBuilder<WeatherResponse>(
                stream: _weatherBloc.outputPosition,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return CityNotFoundWidget();
                  }
                  if (!snapshot.hasData) {
                    return Container();
                  }

                  return WeatherWidget(weather: snapshot.data);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> _handleRequestData(GlobalKey<FormState> _formKey,
  //     String _cityName, WeatherProvider weatherProvider) async {
  //   if (_formKey.currentState.validate()) {
  //     final weather = await WeatherRepository().find(_cityName);

  //     weatherProvider.setWeather(weather);
  //   }
  // }
}
