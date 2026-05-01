import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ApiHelper {
  static final Dio dio = Dio(BaseOptions(
      baseUrl: 'https://ntitodo-production-b847.up.railway.app/api/'));

  static post({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isProtected = false
  }) async{
    String? accessToken ;
    if(isProtected) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      accessToken = prefs.getString('access_token');
    }
    return dio.post(
        endPoint,
        data: isFormData ? FormData.fromMap(data ?? {}) : data,
      options: Options(
        headers: {
          if(isProtected) 'Authorization': 'Bearer $accessToken',
        }
      )
    );
  }
}
