import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nti6/helper/custom_navigator.dart';
import 'package:flutter_nti6/login_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    getTasks();
    super.initState();
  }


  bool isLoading = false;
  List<Map<String, dynamic>> tasks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(onPressed: ()async{
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.remove('access_token');
            goTo(context, LoginView(), NavigatorType.pushAndRemoveUntil);
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: isLoading? Center(child: CircularProgressIndicator(),)
          :
      SafeArea(
        child: ListView.separated(
          padding: REdgeInsets.all(20),
            itemBuilder: (context, index) => TaskItemBuilder(
              taskMap: tasks[index],
            ),
            separatorBuilder: (context, index) => SizedBox(height: 20,),
            itemCount: tasks.length
        ),
      ),
    );
  }

  getTasks()async{
    try{
      setState(() {
        isLoading = true;
      });
      Dio dio = Dio();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var accessToken = prefs.getString('access_token');
      var result = await dio.get(
        'https://ntitodo-production-b847.up.railway.app/api/my_tasks',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken'
          }
        )
      );
      var tasksResponse = result.data as Map<String, dynamic>;
      setState(() {
        tasks = List.generate(tasksResponse['tasks'].length, (index)=>
            tasksResponse['tasks'][index]);
        isLoading = false;
      });

    }
    catch(e){
      print(e.toString());
      setState(() {
        isLoading = false;
      });
      String errorMsg = 'Something went wrong';
      if(e is DioException){
        var errorResponse = e.response?.data as Map<String, dynamic>;
        errorMsg = errorResponse['message'];
        print(errorResponse['message']);
      }
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.red,
              content: Text(errorMsg, style: TextStyle(color: Colors.white),))
      );
    }
  }
}

class TaskItemBuilder extends StatelessWidget {
  const TaskItemBuilder({super.key, required this.taskMap});

  final Map<String, dynamic> taskMap;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffCEEBDC),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 4,
            spreadRadius: 0,
            color: Colors.black.withValues(alpha: 0.25)
          ),
        ]
      ),
      padding: REdgeInsets.all(13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                Text(taskMap['title']),
                SizedBox(height: 13,),
                Text(taskMap['description']),

              ],
            ),
          ),
          Expanded(child: Text(taskMap['created_at'], textAlign: TextAlign.center,))
        ],
      ),
    );
  }
}
