import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_nti6/core/network/end_points.dart';
import 'package:shared_preferences/shared_preferences.dart';
abstract class ApiHelper {
  static final Dio dio = Dio(BaseOptions(baseUrl: EndPoints.baseUrl))
  ..interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      print('REQUEST[${options.method}] => PATH: ${options.path}');
      print('HEADERS: ${options.headers}');
      print('DATA: ${options.data}');
      if(options.data is FormData){
        FormData formData = options.data as FormData;
        print('FORM DATA: ${formData.fields}');
        print('FILES: ${formData.files}');

      }
      return handler.next(options);
    },
    onResponse: (response, handler) {
      print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
      print('DATA: ${response.data}');
      return handler.next(response);
    },
    onError: (error, handler) {
      print('ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}');
      print('DATA: ${error.response?.data}');

      // TODO: handle access token expired error
      return handler.next(error);
    }
  ));

  static Future<Either<String, Map<String, dynamic>>> post(
      {required String endPoint,
      Map<String, dynamic>? data,
      bool isFormData = true,
      bool isProtected = false}) async {
    try {
      dio.interceptors;
      String? accessToken;
      if (isProtected) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        accessToken = prefs.getString('access_token');
      }
      var response = await dio.post(endPoint,
          data: isFormData ? FormData.fromMap(data ?? {}) : data,
          options: Options(headers: {
            if (isProtected) 'Authorization': 'Bearer $accessToken',
          }));
      return right(response.data as Map<String, dynamic>);
    } catch (e) {
      print(e.toString());
      String errorMsg = 'Something went wrong';
      if (e is DioException) {
        var errorResponse = e.response?.data as Map<String, dynamic>;
        errorMsg = errorResponse['message'];
        print(errorResponse['message']);
      }
      return left(errorMsg);
    }
  }
}
