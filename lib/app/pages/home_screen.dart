import 'package:flutter/material.dart';
import 'package:hardi_sgt/app/constant/color_app.dart';
import 'package:hardi_sgt/app/models/hourly_weather.dart';
import 'package:hardi_sgt/app/service/hourly_service.dart';
import 'package:hardi_sgt/app/widgets/card_weather.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HourlyService _HourlyService = HourlyService();
  late Future<List<WeatherList>> _hourlyData;

  // Untuk menampilkan data di atas
  WeatherList? selectedWeather;
  String? locationName; // Tambah variabel lokasi

  @override
  void initState() {
    super.initState();
    _hourlyData = _getHourlyCards();
  }

  Future<List<WeatherList>> _getHourlyCards() async {
    final data = await _HourlyService.getHourlyWeather();

    // Simpan nama kota dari API
    locationName = data.city.name;

    final now = DateTime.now();
    List<WeatherList> sorted = List.from(data.list);
    sorted.sort((a, b) {
      final diffA = (DateTime.parse(a.dtTxt).difference(now)).inMinutes.abs();
      final diffB = (DateTime.parse(b.dtTxt).difference(now)).inMinutes.abs();
      return diffA.compareTo(diffB);
    });

    final selected = sorted.take(5).toList();
    selectedWeather = selected.first;

    return selected;
  }

  void _onCardTap(WeatherList weather) {
    setState(() {
      selectedWeather = weather;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.primary, AppColor.secondary],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 100),
                    Center(
                  child: Text(
                    locationName != null ? "Lokasi: $locationName" : "Lokasi: -",
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: AppColor.white,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    selectedWeather != null
                        ? "${selectedWeather!.main.temp.toStringAsFixed(1)}°C"
                        : "Suhu",
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: AppColor.white,
                    ),
                  ),
                ),
            
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 50,
              child: const Image(image: AssetImage('assets/image/House.png')),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: -20,
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColor.secondary.withOpacity(0.8),
                        AppColor.third.withOpacity(0.8),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(width: 8),
                          Text(
                            "Hourly Forecast",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColor.grey,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Weekly Forecast",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColor.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      FutureBuilder<List<WeatherList>>(
                        future: _hourlyData,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text("Error: ${snapshot.error}"));
                          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(child: Text("No data"));
                          }

                          final weatherList = snapshot.data!;
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: weatherList.map((weather) {
                                final time = DateTime.parse(weather.dtTxt);
                                final temp = weather.main.temp.toStringAsFixed(1) + "°C";
                                return GestureDetector(
                                  onTap: () => _onCardTap(weather),
                                  child: WeatherCard(
                                    title: "${time.hour}:00",
                                    icon: Icons.water_drop,
                                    value: weather.weather[0].description,
                                    temperature: temp,
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
