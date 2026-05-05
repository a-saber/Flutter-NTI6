import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nti6/core/network/api_helper.dart';
import 'package:flutter_nti6/core/network/end_points.dart';
import 'package:flutter_nti6/features/auth/views/login_view.dart';
import 'package:flutter_nti6/features/home/cubit/get_tasks/get_tasks_cubit.dart';
import 'package:flutter_nti6/features/home/cubit/get_tasks/get_tasks_state.dart';
import 'package:flutter_nti6/features/home/data/models/task_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/helper/custom_navigator.dart';
import 'add_task_view.dart';
import 'settings_view.dart';
import 'update_task_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> GetTasksCubit()..getTasks(),
      child: Scaffold(
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              shape: CircleBorder(),
              backgroundColor: Colors.green,
              child: Icon(Icons.add, color: Colors.white,),
              onPressed: (){
                goTo(context, AddTaskView(
                  // callBack: ()=> GetTasksCubit.get(context).getTasks(),
                  getTasksCubit: GetTasksCubit.get(context),
                ));
              });
          }
        ),
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            goTo(context, SettingsView());
          }, icon: Icon(Icons.settings)),
          title: Text('Home'),
          actions: [
            IconButton(onPressed: ()async{
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('access_token');
              goTo(context, LoginView(), NavigatorType.pushAndRemoveUntil);
            }, icon: Icon(Icons.logout))
          ],
        ),
        body: BlocBuilder<GetTasksCubit, GetTasksState>(
          builder: (context, state) {
            if(state is GetTasksLoadingState){
              return Center(child: CircularProgressIndicator(),);
            }
            else if(state is GetTasksErrorState){
              return Center(child: Text(state.error),);
            }
            else if(state is GetTasksSuccessState){
              return SafeArea(
                child: ListView.separated(
                    padding: REdgeInsets.all(20),
                    itemBuilder: (context, index) => TaskItemBuilder(
                      getTasksCubit: GetTasksCubit.get(context),
                      model: state.tasks[index],
                    ),
                    separatorBuilder: (context, index) => SizedBox(height: 20,),
                    itemCount: state.tasks.length
                ),
              );
            }
            return Container();
          }
        ),
      ),
    );
  }

}

class TaskItemBuilder extends StatelessWidget {
  const TaskItemBuilder({super.key, required this.model, required this.getTasksCubit});
  final GetTasksCubit getTasksCubit;
  final TaskModel model;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        goTo(context, UpdateTaskView(
          taskModel: model,
          getTasksCubit: getTasksCubit,
        ));
      },
      child: Container(
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
            // image
            if(model.imagePath != null)
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(model.imagePath??''))
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title
                  Text(model.title??''),
                  SizedBox(height: 13,),
                  Text(model.description??''),

                ],
              ),
            ),
            Expanded(child: Text(model.createdAt??'', textAlign: TextAlign.center,))
          ],
        ),
      ),
    );
  }
}
