import 'package:dio/dio.dart';

class EmailRepository {
  late String api_url;
  late Dio dio;
  EmailRepository(){
    api_url = "http://localhost:3000";
    dio = Dio(BaseOptions(
      baseUrl: "http://localhost:3000",
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
      print('repo == enter catch throw');
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

}