import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_api_repository/weather_api_repository.dart';
import 'package:weather_web/components/narrow_layout.dart';
import 'package:weather_web/components/wide_layout.dart';
import 'package:weather_web/provider/weather_provider.dart';

class WeatherDashboard extends StatefulWidget{
  const WeatherDashboard({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _WeatherDashboardState();
 }

class _WeatherDashboardState extends State<WeatherDashboard>{
  
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WeatherProvider>().initialFromCache();
    });
    print('out of init weather');
  }

  @override
  Widget build(BuildContext context) {
    print("enter weather dashboard");
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints){
          final isWideScreen = constraints.maxWidth > 700;
          return Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: const Color(0xFF4169E1),
                child: const Center(
                  child: Text(
                    'Weather Dashboard',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // Main content
              Expanded(
                child: Container(
                  color: const Color(0xFFE6F0F5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                    child: isWideScreen
                        ? const WideLayout()
                        : const NarrowLayout(),
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }

  Future<void> initWeather(WeatherProvider provider) async{
    if(provider.getIsInitialized()) return;
    print('enter init weather');
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('weather_cached');
    
    if(jsonString != null){
      print("have data");
      final jsonMap = jsonDecode(jsonString);
      final savedAt = DateTime.parse(jsonMap['savedAt']);
      final now = DateTime.now();

      if(savedAt.year == now.year && savedAt.month == now.month && savedAt.day == now.day){
        final List<dynamic> data = jsonMap['forecast'];
        List<Weather> forecast = data.map((item) => Weather.fromJson(item as Map<String, dynamic>, jsonMap['city'])).toList();
        Weather currentWeather = Weather.fromJson(jsonMap['currentWeather'], jsonMap['city']);
        provider.setCurrentWeather(currentWeather);
        provider.setForecast(forecast);
      }else{
        
      }
    }else{
      print("no data");
    }
  }
}