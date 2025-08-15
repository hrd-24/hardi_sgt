import 'package:flutter/material.dart';
import 'package:hardi_sgt/app/constant/color_app.dart';
import 'package:hardi_sgt/app/pages/login_screen.dart';
import 'package:hardi_sgt/app/service/weather_service.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final WeatherService _weatherService = WeatherService();
  late Future<List<WeatherData>> _futureWeather;

  List<WeatherData> _allWeather = [];
  List<WeatherData> _filteredWeather = [];
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _futureWeather = _weatherService.fetchMultipleCities([
      "Jakarta",
      "Bandung",
      "Surabaya",
      "Medan",
      "Makassar",
    ]);
  }

  void _filterCities(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredWeather = _allWeather;
      } else {
        _filteredWeather = _allWeather
            .where((weather) =>
                weather.city.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: AppBar(
        title: const Text('Weather', style: TextStyle(color: AppColor.white)),
        backgroundColor: AppColor.secondary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.white),
          onPressed: () async {
            bool confirmLogout = await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Konfirmasi Logout'),
                content: const Text('Apakah kamu yakin ingin logout?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Batal'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Logout'),
                  ),
                ],
              ),
            );

            if (confirmLogout) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            }
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.primary, AppColor.secondary],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<List<WeatherData>>(
          future: _futureWeather,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("Tidak ada data cuaca"));
            }

            _allWeather = snapshot.data!;
            _filteredWeather = _searchQuery.isEmpty
                ? _allWeather
                : _allWeather
                    .where((weather) => weather.city
                        .toLowerCase()
                        .contains(_searchQuery.toLowerCase()))
                    .toList();

            return Column(
              children: [
                // SEARCH INPUT
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    onChanged: _filterCities,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search, color: AppColor.white),
                      hintText: 'Cari kota...',
                      hintStyle: const TextStyle(color: AppColor.white),
                      filled: true,
                      fillColor: AppColor.secondary.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(color: AppColor.white),
                  ),
                ),

                // LIST CUACA
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      children: _filteredWeather.map((cityWeather) {
                        return Container(
                          height: 200,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColor.third.withOpacity(0.7),
                                AppColor.primary.withOpacity(0.7),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${cityWeather.temp.toStringAsFixed(1)}°C",
                                      style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.white,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      cityWeather.description,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: AppColor.white,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      cityWeather.city,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.white,
                                      ),
                                    ),
                                  ],
                                ),

                                // Bagian Kanan (Icon Cuaca)
                                Image.network(
                                  "https://openweathermap.org/img/wn/${cityWeather.icon}@2x.png",
                                  width: 80,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
