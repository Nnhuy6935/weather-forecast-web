import 'package:dio/dio.dart';

class EmailRepository {
  late String api_url;
  late Dio dio;
  EmailRepository(){
    api_url = "https://weather-forecast-web-zob7.onrender.com";
    dio = Dio(BaseOptions(
      baseUrl: "https://weather-forecast-web-zob7.onrender.com",
      validateStatus: (status){
        // chấp nhận cả các status 400, 409
        return status != null && status < 500;
      }
    ));
  }

  Future<String> registerEmail(String email, String city) async{
    try{  
      final resp = await dio.post(
        '$api_url/api/register',
        data: {
          "email": email,
          "city": city,
        }
      );
      if(resp.statusCode == 200){
        return 'register success';
      }else{
        return resp.data['result']['detail']['error'];
      }
    }catch(error){
      throw error;
    }
  }

  Future<void> unsubscribeEmail(String email) async{
    try{
      await dio.post(
        '$api_url/api/unsubscribe',
        data: {
          "email": email,
        }
      );
    }catch(error){
      throw error;
    }
  }

  Future<String> verifyEmail(String token) async{
    try{
      final response = await dio.post(
        '${api_url}/api/confirm',
        data: {
          "token": token,
        }
      );
      if(response.statusCode == 200){
        return "Verify successful";
      }else{
        return "verify failed";
      }
    }catch(error){
      return "Network or system error";
    }
  }

}