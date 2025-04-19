import 'package:flutter/material.dart';
import 'package:weather_web/components/current_weather_session.dart';
import 'package:weather_web/components/following_weather_session.dart';
import 'package:weather_web/components/search_session.dart';

class WideLayout extends StatelessWidget{
  const WideLayout({super.key});
  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search section
        Expanded(
          flex: 1,
          child: SearchSession(),
        ),
        SizedBox(width: 16),
        // Weather info section
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CurrentWeatherSession(),
              SizedBox(height: 25),
              FollowingWeatherSession(),
            ],
          ),
          ),
        ),
      ],
    );
  }
}
