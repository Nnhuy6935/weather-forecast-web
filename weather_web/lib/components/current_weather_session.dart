import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_web/provider/weather_provider.dart';

class CurrentWeatherSession extends StatelessWidget{
  const CurrentWeatherSession({super.key});
  @override
  Widget build(BuildContext context){
    WeatherProvider weatherProvider = Provider.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF4169E1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${weatherProvider.currentWeather.city} (${weatherProvider.currentWeather.time})',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Temperature: ${weatherProvider.currentWeather.temperature}°C',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Wind: ${weatherProvider.currentWeather.wind} M/S',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Humidity: ${weatherProvider.currentWeather.humidity}%',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Image.network(
                weatherProvider.currentWeather.icon, 
                width: 64, height: 64,),
              const SizedBox(height: 8),
              Text(
                weatherProvider.currentWeather.conditionDescription,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
