import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nti6/core/components/default_btn.dart';
import 'package:flutter_nti6/core/components/default_flag_image.dart';
import 'package:flutter_nti6/core/components/default_text_field.dart';
import 'package:flutter_nti6/core/components/image_manager.dart';
import 'package:flutter_nti6/core/helper/custom_snack_bar.dart';
import 'package:flutter_nti6/core/translation/translation_keys.dart';
import 'package:flutter_nti6/features/home/cubit/delete_task/delete_task_cubit.dart';
import 'package:flutter_nti6/features/home/cubit/delete_task/delete_task_state.dart';
import 'package:flutter_nti6/features/home/cubit/get_tasks/get_tasks_cubit.dart';
import 'package:flutter_nti6/features/home/data/models/task_model.dart';
import 'package:get/get.dart';

import '../cubit/update_task/update_task_cubit.dart';
import '../cubit/update_task/update_task_state.dart';

class UpdateTaskView extends StatelessWidget {
  const UpdateTaskView(
      {super.key,
      // required this.callBack,
      required this.getTasksCubit,
      required this.taskModel});

  // final void Function() callBack;
  final GetTasksCubit getTasksCubit;
  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UpdateTaskCubit(taskModel),
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) => BlocProvider(
                            create: (context) => DeleteTaskCubit(taskModel),
                            child:
                                BlocConsumer<DeleteTaskCubit, DeleteTaskState>(
                                    listener: (context, state) {
                              if (state is DeleteTaskSuccessState) {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                getTasksCubit.getTasks();
                              }
                            }, builder: (context, state) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: Column(
                                  children: [
                                    if (state is DeleteTaskLoadingState)
                                      LinearProgressIndicator(),
                                    Text('Are You Sure?'),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        DeleteTaskCubit.get(context)
                                            .deleteTask();
                                      },
                                      child: Text(
                                        'Yes, Delete',
                                        style: TextStyle(color: Colors.red),
                                      )),
                                  TextButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Cancel')),
                                ],
                              );
                            }),
                          ));
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              )
            ],
          ),
          body: BlocConsumer<UpdateTaskCubit, UpdateTaskState>(
              listener: (context, state) {
            if (state is UpdateTaskErrorState) {
              CustomSnackBar.showSnackBar(state.error, SnackBarState.error);
            } else if (state is UpdateTaskSuccessState) {
              CustomSnackBar.showSnackBar(state.message, SnackBarState.success);
              Navigator.pop(context);
              getTasksCubit.getTasks();
              // callBack();
            }
          }, builder: (context, state) {
            var cubit = UpdateTaskCubit.get(context);
            return SingleChildScrollView(
              child: Column(children: [


                ImageManager(
                  networkImagePath: taskModel.imagePath,
                  onImagePicked: (fileImagePath){
                    cubit.fileImagePath = fileImagePath;
                  },
                  selectedImageBuilder: (selectedImagePath){
                   return ClipRRect(
                       borderRadius: BorderRadius.circular(20),
                       child: Image.file(File(selectedImagePath), fit: BoxFit.cover,));
                  },
                  unselectedImageBuilder: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withValues(alpha: 0.25),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            spreadRadius: 0)
                      ],
                      image: DecorationImage(image: AssetImage('assets/images/flag.png'), fit: BoxFit.cover),
                    ),
                  )
                ),


                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                      children: [
                        DefaultTextField(
                          hintText: TranslationKeys.taskTitle.tr,
                          controller: cubit.title,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This Field is Required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DefaultTextField(
                            hintText: TranslationKeys.taskDescription.tr,
                            controller: cubit.description),
                        SizedBox(
                          height: 40,
                        ),
                        if (state is UpdateTaskLoadingState)
                          CircularProgressIndicator()
                        else
                          DefaultBtn(
                            text: TranslationKeys.updateTask.tr,
                            onTap: cubit.updateTask,
                          )
                      ],
                    ),
                  ),
                )
              ]),
            );
          }),
        ));
  }
}
