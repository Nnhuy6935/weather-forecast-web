import 'package:flutter/material.dart';
import 'package:weather_api_repository/weather_api_repository.dart';

class ForecastGrid extends StatelessWidget {
  final double width;
  final List<Weather> forecast;
  const ForecastGrid({
    required this.width,
    required this.forecast,
  });
  @override
  Widget build(BuildContext context) {
    int crossAxisCount = width < 500
        ? 1
        : width < 950
            ? 2
            : 4;
    if (forecast.isNotEmpty) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          // childAspectRatio: 1.1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: forecast.length,
        itemBuilder: (context, index) {
          final day = forecast[index];
          return Container(
            constraints: const BoxConstraints(maxWidth: 50, maxHeight: 50),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF6E7781),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '(${day.time})',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Image.network(
                  day.icon,
                  width: 64,
                  height: 64,
                ),
                const SizedBox(height: 8),
                Text(
                  'Temp: ${day.temperature}°C',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Wind: ${day.wind} M/S',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Humidity: ${day.humidity}%',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      return const Center(
        child: Text('No data'),
      );
    }
  }
}
