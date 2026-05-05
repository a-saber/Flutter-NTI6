import 'package:flutter/material.dart';
import 'package:flutter_nti6/core/cache/cache_helper.dart';
import 'package:flutter_nti6/core/cache/cache_keys.dart';
import 'package:flutter_nti6/core/components/custom_svg.dart';
import 'package:flutter_nti6/features/auth/views/login_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/components/default_btn.dart';
import '../../../core/helper/custom_navigator.dart';
import '../../auth/views/register_view.dart';

class LetStartView extends StatelessWidget {
  const LetStartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 22.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomSvg(
              imagePath: 'assets/images/vector.svg',
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
              text: "Let's Start",
              onTap: ()async{
                await CacheHelper.setValue(key: CacheKeys.firstOpen, value: false);
                goTo(context, LoginView());
              },
            )
          ],
        ),
      )),
    );
  }
}

