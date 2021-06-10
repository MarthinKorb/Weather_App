import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/shared/LocationService/infra/geolocator/repositories/LocationRepository.dart';
import 'package:weather_app/src/modules/weather/infra/model/weather_response.dart';
import 'package:weather_app/src/modules/weather/infra/model/weather_response2.dart';
import 'package:weather_app/src/modules/weather/ui/around_cities_widget.dart';
import 'package:weather_app/src/modules/weather/ui/weather_bloc.dart';
import 'package:weather_app/src/modules/weather/ui/weather_widget.dart';

import 'city_not_found_widget.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherBloc = WeatherBloc();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _weatherBloc.inputCity.close();
    _weatherBloc.inputLatLong.close();
  }

  @override
  Widget build(BuildContext context) {
    LocationRepository()
        .determinePosition()
        .then((value) => _weatherBloc.inputLatLong.add(value));

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
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () {
          return LocationRepository()
              .determinePosition()
              .then((value) => _weatherBloc.inputLatLong.add(value));
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.black12.withOpacity(0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StreamBuilder<WeatherResponse>(
                stream: _weatherBloc.outputByCity,
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
              Container(
                child: StreamBuilder<WeatherResponse2>(
                  stream: _weatherBloc.outputPosition,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return CityNotFoundWidget();
                    }
                    if (!snapshot.hasData) {
                      return Column(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 18),
                          Text(
                            'Buscando os dados das cidades próximas...',
                            style: GoogleFonts.abel(fontSize: 16),
                          )
                        ],
                      );
                    }

                    return AroundCitiesWidget(weather: snapshot.data);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
