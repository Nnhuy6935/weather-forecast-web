import 'package:dio/dio.dart';
import 'package:weather_api_repository/src/model/model.dart';

class WeatherRepository{
  final Dio dio = Dio();
  // final String api_url = dotenv.env['WEATHER_API_URL'] ?? "https://api.weatherapi.com/v1";
  // final String api_key = dotenv.env['API_KEY'] ?? "api_key";
  late String api_url;
  late String api_key;
  WeatherRepository() {
    // api_url = env?['WEATHER_API_URL'];
    // api_key = env?['API_KEY'];
    api_url = "https://api.weatherapi.com/v1";
    api_key = "a1a63b1e03bf4e23bae110646251704";
    
  }

  Future<List<Weather>> getWeathers(String location) async{
    try{
      print('$api_url/forecast.json?q=$location&days=14&key=$api_key');
      final response = await dio.get('$api_url/forecast.json?q=$location&days=14&key=$api_key');
      final String city = response.data['location']['name'];
      List<Weather> result = [];
      List<dynamic> days = response.data['forecast']['forecastday'] as List;
      result = days.map((item) => Weather.fromJson(item as Map<String,dynamic>, city)).toList();
      return result;
    }catch(error){
      throw Exception(error);
    }
  }


}