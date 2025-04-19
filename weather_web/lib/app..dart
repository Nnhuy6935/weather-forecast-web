import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_web/views/register_screen.dart';
import 'package:weather_web/views/weather_confirm.dart';
import 'package:weather_web/views/weather_dashboard.dart';

class WeatherApp extends StatelessWidget{
  const WeatherApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: "Weather Web",
      debugShowCheckedModeBanner: false,

    );
  }
}


final GoRouter _router = GoRouter(
  initialLocation: Uri.base.path,
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state){
        return const WeatherDashboard();
      }
    ),
    GoRoute(
      path: '/confirm',
      builder: (BuildContext context, GoRouterState state){
        return const WeatherConfirm();
      }
    ),
    GoRoute(
      path: '/register',
      builder: (BuildContext context, GoRouterState state){
        return const RegisterScreen();
      }
    ),
  ]);
