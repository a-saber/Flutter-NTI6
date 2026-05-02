import 'package:flutter_nti6/core/network/api_helper.dart';

import '../../../../core/cache/cache_helper.dart';
import '../../../../core/cache/cache_keys.dart';
import '../../../../core/network/end_points.dart';

class AuthRepo{

  login({
    required String username,
    required String password
}) async {

    // right
    var response = await ApiHelper.post(
      endPoint: EndPoints.login,
      data: {'username': username, 'password': password},
    );
    response.fold(
            (error) {


        },
            (map)async {
          await CacheHelper.setValue(
              key: CacheKeys.accessToken,
              value: map[CacheKeys.accessToken]
          );
          await CacheHelper.setValue(
              key: CacheKeys.refreshToken,
              value: map[CacheKeys.refreshToken]
          );

        }
    );

  }


  register({required String username, required String password}) async {

    var response = await ApiHelper.post(
        endPoint: EndPoints.register,
        data: {'username': username, 'password': password});

    response.fold((error) {


    },
            (map) {

        }
    );

  }
}