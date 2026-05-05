import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nti6/core/components/default_btn.dart';
import 'package:flutter_nti6/core/components/default_flag_image.dart';
import 'package:flutter_nti6/core/components/default_text_field.dart';
import 'package:flutter_nti6/core/helper/custom_snack_bar.dart';
import 'package:flutter_nti6/core/translation/translation_keys.dart';
import 'package:flutter_nti6/features/home/cubit/add_task/add_task_cubit.dart';
import 'package:flutter_nti6/features/home/cubit/add_task/add_task_state.dart';
import 'package:flutter_nti6/features/home/cubit/get_tasks/get_tasks_cubit.dart';
import 'package:get/get.dart';

class AddTaskView extends StatelessWidget {
  const AddTaskView({super.key,
    // required this.callBack,
    required this.getTasksCubit
  });
  // final void Function() callBack;
  final GetTasksCubit getTasksCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AddTaskCubit(),
        child: Scaffold(
          body: BlocConsumer<AddTaskCubit, AddTaskState>(
            listener: (context, state){
              if(state is AddTaskErrorState){
                CustomSnackBar.showSnackBar(state.error, SnackBarState.error);
              }
              else if(state is AddTaskSuccessState){
                CustomSnackBar.showSnackBar(state.message, SnackBarState.success);
                Navigator.pop(context);
                getTasksCubit.getTasks();
                // callBack();
              }
            },
            builder: (context, state) {
              var cubit = AddTaskCubit.get(context);
              return Column(children: [
                DefaultFlagImage(),
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
                          validator: (value){
                            if(value == null || value.isEmpty){
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
                            controller:cubit.description),

                        SizedBox(
                          height: 20,
                        ),
                        DefaultTextField(
                          readOnly: true,
                            onTap: ()async{
                            DateTime? newDateTime = await showDatePicker(
                            context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(Duration(days: 20)),
                            );
                            if(newDateTime != null){
                              cubit.onDateChanged(newDateTime);
                            }
                            },
                            hintText: TranslationKeys.taskDescription.tr,
                          controller: TextEditingController(
                            text: cubit.selectedDate ==null? '': cubit.selectedDate.toString()
                          ),
                          prefixIconData: Icons.calendar_month,
                        ),

                        SizedBox(
                          height: 40,
                        ),
                        if(state is AddTaskLoadingState)
                          CircularProgressIndicator()
                        else
                        DefaultBtn(
                          text: TranslationKeys.addTask.tr,
                          onTap:cubit.addTask,
                        )
                      ],
                    ),
                  ),
                )
              ]);
            }
          ),
        ));
  }
}
