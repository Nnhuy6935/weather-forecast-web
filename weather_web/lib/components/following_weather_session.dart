import 'package:flutter/material.dart';
import 'package:weather_web/components/forecast_grid.dart';

class FollowingWeatherSession extends StatelessWidget{
  const FollowingWeatherSession({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '4-Day Forecast',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            return ForecastGrid(width: constraints.maxWidth,);
          },
        ),
      ],
    );
  }
}