import 'package:flutter/material.dart';
import 'package:flutter_nti6/register_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'start_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((v) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LetStart()));
      print('object');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/logo.svg',
              height: 343.h,
              width: 334.w,
            ),
            SizedBox(
              height: 40.h,
            ),
            Text('ToDo')
          ],
        ),
      ),
    );
  }
}
