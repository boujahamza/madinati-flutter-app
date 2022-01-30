class WeatherForecast {
  final String location;
  final String currentTemp;
  final String currentIcon;
  final forecast;

  WeatherForecast(
      {required this.location,
      required this.currentTemp,
      required this.currentIcon,
      required this.forecast});

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
        location: json["location"]["name"],
        currentTemp: json["current"]["temp_c"].toString(),
        currentIcon: json["current"]["condition"]["icon"],
        forecast: json["forecast"]["forecastday"].map((day) {
          return <String>[
            DateTime.fromMillisecondsSinceEpoch(day["date_epoch"] * 1000)
                    .day
                    .toString() +
                "/" +
                DateTime.fromMillisecondsSinceEpoch(day["date_epoch"] * 1000)
                    .month
                    .toString(),
            day["day"]["avgtemp_c"].toString(),
            day["day"]["condition"]["icon"]
          ];
        }).toList());
  }
}
