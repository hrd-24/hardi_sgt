import 'dart:convert';

import 'package:hardi_sgt/app/models/hourly_weather.dart';
import 'package:hardi_sgt/app/service/endpoint.dart';
import 'package:http/http.dart' as http;

class HourlyService {
  final double lat = -6.2; 
  final double lon = 106.8;

  Future<WeatherResponse> getHourlyWeather() async {
    final url =
        '${EndPoint.baseUrl}/data/2.5/forecast?lat=$lat&lon=$lon&appid=${EndPoint.apiKey}&units=metric';
    
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return WeatherResponse.fromJson(json.decode(response.body));
      } else {
        print(
          'Gagal memuat data cuaca. Status: ${response.statusCode}, Body: ${response.body}',
        );

        throw Exception(
          'Error ${response.statusCode}: ${response.reasonPhrase ?? "Tidak diketahui"}',
        );
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}
