import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_nti6/core/cache/cache_helper.dart';
import 'package:flutter_nti6/core/cache/cache_keys.dart';
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
    onError: (error, handler)async {
      print('ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}');
      print('DATA: ${error.response?.data}');
      String? errorMsg;
      if(error.response?.data is Map<String, dynamic>){
        errorMsg = (error.response?.data as Map<String, dynamic>)['message'];
      }
      // handle access token expired error
      if(errorMsg?.contains('Token has expired.') == true){
        // implement refresh token request
        var result = await post(
          endPoint: EndPoints.refresh,
          headers: {
            'Authorization': 'Bearer ${CacheHelper.getValue(CacheKeys.refreshToken)}',
          }
        );
        result.fold(
            (error){
              // goTo(context, LoginView());
              print(error);
            },
            (map)async{
              await CacheHelper.setValue(key: CacheKeys.accessToken, value: map['access_token']);
              var oldOptions = error.requestOptions;
              oldOptions.headers['Authorization'] = 'Bearer ${CacheHelper.getValue(CacheKeys.accessToken)}';
              var newResponse = await dio.fetch(oldOptions);
              return handler.resolve(newResponse);
            }
        );
      }

      return handler.next(error);
    }
  ));

  static Future<Either<String, Map<String, dynamic>>> post(
      {required String endPoint,
      Map<String, dynamic>? data,
      Map<String, dynamic>? headers,
      bool isFormData = true,
      bool isProtected = false,

      }) async {
    try {
      String? accessToken;
      if (isProtected) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        accessToken = prefs.getString('access_token');
      }
      var response = await dio.post(endPoint,
          data: isFormData ? FormData.fromMap(data ?? {}) : data,
          options: Options(headers: {
            if (isProtected) 'Authorization': 'Bearer $accessToken',
            ...?headers
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
  static Future<Either<String, Map<String, dynamic>>> get(
      {required String endPoint,
      Map<String, dynamic>? data,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters,
      bool isFormData = true,
      bool isProtected = false,

      }) async {
    try {
      String? accessToken;
      if (isProtected) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        accessToken = prefs.getString('access_token');
      }
      var response = await dio.get(endPoint,
          data: isFormData ? FormData.fromMap(data ?? {}) : data,
          queryParameters: queryParameters,
          options: Options(headers: {
            if (isProtected) 'Authorization': 'Bearer $accessToken',
            ...?headers
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
