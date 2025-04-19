import 'package:email_repository/email_repository.dart';
import 'package:flutter/material.dart';

class WeatherConfirm extends StatefulWidget{
  const WeatherConfirm();
  @override
  State<StatefulWidget> createState() => _WeatherConfirmState();
}

class _WeatherConfirmState extends State<WeatherConfirm>{
  String? status;
  // Dio dio = Dio();
  late EmailRepository _emailRepository;

  @override
  void initState() {
    super.initState();
    _emailRepository = EmailRepository();
    _handleConfirm();
  }
  @override
  Widget build(BuildContext context) {
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
    String resp = await _emailRepository.verifyEmail(tokenParam!);
    setState(() => status = resp);
  }
  
}
