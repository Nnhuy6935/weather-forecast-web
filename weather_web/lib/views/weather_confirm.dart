import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class WeatherConfirm extends StatefulWidget{
  const WeatherConfirm();
  @override
  State<StatefulWidget> createState() => _WeatherConfirmState();
}

class _WeatherConfirmState extends State<WeatherConfirm>{
  String? status;
  Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    _handleConfirm();
  }
  @override
  Widget build(BuildContext context) {
    print("enter confirm screen");
    return Scaffold(
      body: Center(
        child: status == null 
          ? const CircularProgressIndicator()
          : Text(
            status!,
            style: const TextStyle(fontSize: 18),
          ),
      ),
    );
  }

  void _handleConfirm() async{
    final uri = Uri.base;
    final tokenParam = uri.queryParameters['token'];
    if(tokenParam == null){
      setState(() => status = 'can not find verify token');
    }
    print(tokenParam);
    try{
      final response = await dio.post(
        'http://localhost:3000/api/confirm',
        data: {
          "token": tokenParam,
        } 
      );
      if(response.statusCode == 200){
        setState(() => status = "verify successful");
      }else {
        setState(() => status = "verify failed");
      }
    }catch(error){
      print(error);
      setState(() => status = "network or system error");
    }
  }
  
}
