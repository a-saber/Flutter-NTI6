import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/cache/cache_helper.dart';
import 'features/onboarding/views/splash_view.dart';

void main()async{

  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: SplashView(),
          // home: MainLayout(),
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
