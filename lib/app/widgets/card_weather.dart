import 'package:flutter/material.dart';
import 'package:hardi_sgt/app/constant/color_app.dart';

class WeatherCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String value;
  final String temperature;

  const WeatherCard({
    super.key,
    required this.title,
    required this.icon,
    required this.value,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        color: AppColor.third,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontSize: 16,color: AppColor.white)),
            const SizedBox(height: 20),
            Icon(icon, size: 32, color: AppColor.white),
            Text(value, style: const TextStyle(fontSize: 16,color: AppColor.white)),
            const SizedBox(height: 20),
            Text(temperature, style: const TextStyle(fontSize: 16,color: AppColor.white )),
          ],
        ),
      ),
    );
  }
}
