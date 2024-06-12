class HourPredictions {
  String temperature = "";
  String condition = "";
  String feel = "";
  String datetime = "";
  String humidity = "";
  String wind = "";
  String airQuality = "";
  String visibility = "";
  String icon = "";

  HourPredictions(this.temperature, this.datetime, this.condition, this.feel, this.humidity,
      this.wind, this.airQuality, this.visibility, this.icon);

  HourPredictions.fromJson(Map jsonResponse)
      : temperature = jsonResponse["temp"].toString(),
        condition = jsonResponse["conditions"].toString(),
        datetime = jsonResponse["datetime"].toString(),
        feel = jsonResponse["feelslike"].toString(),
        humidity = jsonResponse["humidity"].toString(),
        wind = jsonResponse["windspeed"].toString(),
        airQuality = jsonResponse["dew"].toString(),
        icon = jsonResponse["icon"].toString(),
        visibility = jsonResponse["visibility"].toString();
}
