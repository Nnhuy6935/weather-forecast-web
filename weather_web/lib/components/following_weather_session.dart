import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_web/components/forecast_grid.dart';
import 'package:weather_web/provider/weather_provider.dart';

class FollowingWeatherSession extends StatelessWidget{
  // final List<Weather> forecast;
  // const FollowingWeatherSession({
  //   required this.forecast,
  // });
  const FollowingWeatherSession();
  @override
  Widget build(BuildContext context) {
    WeatherProvider weatherProvider = Provider.of(context);
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
            return ForecastGrid(width: constraints.maxWidth, forecast: weatherProvider.forecast ,);
          },
        ),
      ],
    );
  }
}