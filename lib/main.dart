import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'features/onboarding/views/splash_view.dart';

void main(){
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
