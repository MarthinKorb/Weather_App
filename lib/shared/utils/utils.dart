class Utils {
  static String convertKelvinToCelsius(double kelvin) {
    if (kelvin == null) {
      return '-';
    }
    return (kelvin - 273.15).floor().toStringAsFixed(0).toString() + '°C';
  }
}
