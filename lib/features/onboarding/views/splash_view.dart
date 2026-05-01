import 'package:flutter/material.dart';
import 'package:flutter_nti6/core/components/custom_svg.dart';
import 'package:flutter_nti6/core/helper/custom_navigator.dart';
import 'package:flutter_nti6/features/home/views/home_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'start_view.dart';



class SplashView extends StatefulWidget{
  @override
  State<SplashView> createState() {
    return SplashViewState();
  }
}

class SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(Duration(
      seconds: 2
    )).then((v) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('access_token');
      goTo(context, accessToken != null? HomeView():LetStartView(), NavigatorType.pushReplacement);

    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSvg(
              imagePath: 'assets/images/logo.svg',
              height: 343.h,
              width: 334.w,
            ),
            SizedBox(height: 50,),
            Text('ToDo')
          ],
        ),
      ),
    );
  }

}











// class SplashView extends StatefulWidget {
//   const SplashView({super.key});
//
//   @override
//   State<SplashView> createState() => _SplashViewState();
// }
//
// class _SplashViewState extends State<SplashView> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration(seconds: 2)).then((v) {
//       Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//               builder: (context) => LetStart()));
//       print('object');
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SvgPicture.asset(
//               'assets/images/logo.svg',
//               height: 343.h,
//               width: 334.w,
//             ),
//             SizedBox(
//               height: 40.h,
//             ),
//             Text('ToDo')
//           ],
//         ),
//       ),
//     );
//   }
// }
