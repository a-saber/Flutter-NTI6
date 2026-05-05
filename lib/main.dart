import 'package:flutter/material.dart';
import 'package:flutter_nti6/core/cache/cache_keys.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'core/cache/cache_helper.dart';
import 'core/translation/translation_helper.dart';
import 'features/onboarding/views/splash_view.dart';
import 'test_maps.dart';

void main()async{

  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String? lang = CacheHelper.getValue(CacheKeys.lang) as String?;
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) {
        return GetMaterialApp(
          translations: TranslationHelper(),
          locale: Locale( lang ?? 'en'),
          home: SplashView(),
          // home: TestMaps(),
        );
      }
    );
  }
}



/*

  MVVM
   M: Model,
   V: View,
   VM: ViewModel

*/
