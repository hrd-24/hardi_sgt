import 'dart:convert';
import 'package:hardi_sgt/app/service/endpoint.dart';
import 'package:http/http.dart' as http;

class WeatherData {
  final String city;
  final double temp;
  final String description;
  final String icon;

  WeatherData({
    required this.city,
    required this.temp,
    required this.description,
    required this.icon,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      city: json['name'],
      temp: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
  }
}

class WeatherService {
  Future<List<WeatherData>> fetchMultipleCities(List<String> cityNames) async {
    List<WeatherData> result = [];

    for (String city in cityNames) {
      final url =
          "${EndPoint.baseUrl}/data/2.5/weather?q=$city,id&units=metric&lang=id&appid=${EndPoint.apiKey}";
      final res = await http.get(Uri.parse(url));

      if (res.statusCode == 200) {
        result.add(WeatherData.fromJson(jsonDecode(res.body)));
      } else {
        print(
          "Gagal memuat data untuk kota $city. Status code: ${res.statusCode}, body: ${res.body}",
        );

      }
    }
    return result;
  }
}

