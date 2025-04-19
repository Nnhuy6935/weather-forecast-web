import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_api_repository/weather_api_repository.dart';
import 'package:weather_web/provider/weather_provider.dart';

class SearchSession extends StatefulWidget{
  const SearchSession({super.key});
  @override
  State<StatefulWidget> createState() => _SearchState();
}

class _SearchState extends State<SearchSession>{
 late TextEditingController _cityController;
 late WeatherRepository weatherRepository;
 late bool isLoading;
  @override
  void initState() {
    super.initState();
    _cityController = TextEditingController();
    weatherRepository = WeatherRepository();
    isLoading = false;
  }
  
  void updateLoadingState(){
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    WeatherProvider weatherProvider = Provider.of(context);
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter a City Name',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                hintText: 'E.g., New York, London, Tokyo',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async{
                updateLoadingState();
                List<Weather> data = await weatherRepository.getWeathers(_cityController.value.text);
                // handle data 
                weatherProvider.setCurrentWeather(data.first);
                weatherProvider.setForecast(data.sublist(1));
                await saveToReferences(weatherProvider);
                updateLoadingState();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4169E1),
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: !isLoading 
              ?const Text(
                'Search',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              )
              : const SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator( color:  Colors.white, strokeWidth: 2.0,),
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Expanded(
                  child: Divider(color: Colors.grey),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'or',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Expanded(
                  child: Divider(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                // Get location functionality would go here
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFF6E7781),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: const Text(
                'Use Current Location',
                style: TextStyle(fontSize: 16),
              ),
            ),
            // register notification button 
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                context.go('/register');
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFF6E7781),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: const Text(
                'Register Notification',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Future<void> saveToReferences(WeatherProvider provider) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    final forecast = provider.forecast.map((item) => item.toJson()).toList();
    final currentWeather = provider.currentWeather.toJson();
    final jsonString = jsonEncode({
      'currentWeather': currentWeather,
      'forecast': forecast,
      'savedAt': DateTime.now().toIso8601String(),
    });
    await pref.setString('weather_cached', jsonString);
  }
}