class APIData {
  final int id;
  final String geom;
  final String descriptio;
  final DateTime time;
  final String copyright;
  final String province;
  final String stationname;
  final int rainfallValue;
  final String rainfallUnit;
  final int temperatureValue;
  final String temperatureUnit;
  final String geojson;

  APIData(this.id, this.geom, this.descriptio, this.time, this.copyright, this.province, this.stationname, this.rainfallValue, this.rainfallUnit, this.temperatureValue, this.temperatureUnit,
      this.geojson);
}
