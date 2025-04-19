
class Weather {
  final String city;
  final String time;
  final double temperature;
  final String icon;
  final double wind;       // (M/S)
  final double humidity;   // (%)
  final String conditionDescription;

  const Weather({
    required this.city,
    required this.time,
    required this.temperature,
    required this.icon,
    required this.wind,
    required this.humidity,
    required this.conditionDescription,
  });
  static const empty = Weather(
    city: "city", 
    time: "yyyy-mm-dd", 
    temperature: 0, 
    icon: "https://cdn-icons-png.flaticon.com/128/648/648198.png", 
    wind: 0, 
    humidity: 0, 
    conditionDescription: "null"
  );
  
  factory Weather.fromJson(Map<String, dynamic> json, String cityName){
    return Weather(
      city: cityName, 
      time: json['date'], 
      temperature: json['day']['avgtemp_c'], 
      icon: "https:" + json['day']['condition']['icon'], 
      wind: json['day']['maxwind_mph'], 
      humidity: json['day']['avghumidity'], 
      conditionDescription: json['day']['condition']['text']
    );
  }
  factory Weather.fromPrefJson(Map<String,dynamic> json){
    return Weather(
      city: json['city'], 
      time: json['time'], 
      temperature: json['temperature'], 
      icon: json['icon'], 
      wind: json['wind'], 
      humidity: json['humidity'], 
      conditionDescription: json['conditionDescription']
    );
  }
  Map<String, dynamic> toJson() => {
    'city': city,
    'time': time,
    'temperature': temperature,
    'icon': icon,
    'wind': wind,
    'humidity': humidity,
    'conditionDescription': conditionDescription,
  };
}


// xử lý đường link hình ảnh hợp lệ : thêm https: vào link ảnh lấy về 