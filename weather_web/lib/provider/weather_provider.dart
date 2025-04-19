import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_api_repository/weather_api_repository.dart';

class WeatherProvider extends ChangeNotifier{
  Weather currentWeather = Weather.empty;
  List<Weather> forecast = [];
  bool _isInitilized = false;      // handle over looping 

  bool getIsInitialized() => _isInitilized;
  void setIsInitialized(bool value) => _isInitilized = value;
  void setCurrentWeather(Weather value){
    this.currentWeather = value;
    notifyListeners();
  }

  void setForecast(List<Weather> weatherForecast){
    forecast = weatherForecast;
    notifyListeners();
  }

  Weather getCurrentWeather(){
    return currentWeather;
  }

  List<Weather> getForecast(){
    return forecast;
  }

  Future<void> initialFromCache() async{
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('weather_cached');
    
    if(jsonString != null){
      final jsonMap = jsonDecode(jsonString);
      final savedAt = DateTime.parse(jsonMap['savedAt']);
      final now = DateTime.now();

      if(savedAt.year == now.year && savedAt.month == now.month && savedAt.day == now.day){
        List<dynamic> data = jsonMap['forecast'];
        List<Weather> forecast = data.map((item) => Weather.fromPrefJson(item as Map<String, dynamic>)).toList();
        Weather currentWeather = Weather.fromPrefJson(jsonMap['currentWeather']);
        this.currentWeather = currentWeather;
        this.forecast = forecast;
        notifyListeners();
      }else{
        
      }
    }else{
    }
  }
}