import 'package:flutter/material.dart';
import 'package:flutter_nti6/helper/custom_navigator.dart';
import 'package:flutter_nti6/register_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'components/default_btn.dart';

class LetStart extends StatelessWidget {
  const LetStart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 22.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset(
              'assets/images/vector.svg',
              height: 340.h,
              width: 300.w,
            ),
            Text(
              'Welcome To \nDo It !',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24.sp,
                  color: Color(0xff24252C),
                  fontWeight: FontWeight.w400),
            ),
            Text(
              "Ready to conquer your tasks? Let's Do It together.",
              style: TextStyle(
                  fontSize: 16.sp,
                  color: Color(0xff6E6A7C),
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            DefaultBtn(
              text: 'Get Started',
              onTap: () {
                goTo(context, RegisterView(), NavigatorType.pushReplacement);
              },
            )
          ],
        ),
      )),
    );
  }
}
