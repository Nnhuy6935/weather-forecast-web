import 'package:flutter/material.dart';
import 'package:weather_web/components/current_weather_session.dart';
import 'package:weather_web/components/following_weather_session.dart';
import 'package:weather_web/components/search_session.dart';

class NarrowLayout extends StatelessWidget{
  // final Weather currentWeather;
  // final List<Weather> listWeather;
  // const NarrowLayout({
  //   required this.currentWeather,
  //   required this.listWeather,
  // });
  const NarrowLayout();
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchSession(),
          SizedBox(height: 16),
          CurrentWeatherSession(),
          SizedBox(height: 16),
          FollowingWeatherSession(),
        ],
      ),
    );
  }
}

