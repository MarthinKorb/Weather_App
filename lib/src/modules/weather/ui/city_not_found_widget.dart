import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CityNotFoundWidget extends StatelessWidget {
  const CityNotFoundWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.5,
          // width: double.infinity,
          child: Text(
            'Cidade não encontrada...',
            style: GoogleFonts.abel(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
