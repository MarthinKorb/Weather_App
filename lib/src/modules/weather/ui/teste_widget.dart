import 'package:flutter/material.dart';
import 'package:weather_app/shared/LocationService/infra/geolocator/repositories/LocationRepository.dart';

class TesteWidget extends StatelessWidget {
  const TesteWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App'),
      ),
      body: FutureBuilder(
        future: LocationRepository().determinePosition(),
        builder: (context, snapshot) {
          print(snapshot.error);
          return Center(
            child: Text(snapshot.data.toString()),
          );
        },
      ),
    );
  }
}
