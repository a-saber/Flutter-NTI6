
import 'package:flutter/material.dart';
import 'package:flutter_nti6/test_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'register_view.dart';
import 'splash_view.dart';
import 'test_stf.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder:(_, child)=> MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashView(),
      ),
    );
  }
}





class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: Icon(Icons.arrow_back, color: Colors.white,),
        title: Text('Home Screen'),
        // centerTitle: false,
        actions: [
          Icon(Icons.add),
          Icon(Icons.search),
          SizedBox(width: 10,),
          Text('Add'),
          SizedBox(width: 10,)
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 20,
                itemBuilder: (context, index)=> Text('User $index')
            ),
          ),
          SizedBox(height: 20,),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index){
                return Text('Hello $index');
              },
              itemCount: 40,
              // shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
            ),
          ),
        ],
      ),
    );
  }

}

class UserContainer extends StatelessWidget {
  const UserContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          right: 20,
          left: 10
      ),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 10,
                spreadRadius: 1
            )
          ]

      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey
            ),
            child: Icon(Icons.person),
          ),

          SizedBox(width: 20,),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              Text('Welcome',style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold
              ),),
              Text('Ahmed saber',style: TextStyle(
                  fontSize: 20
              ),),

            ],
          )

        ],
      ),
    );
  }
}































