import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nti6/features/home/data/repo/home_repo.dart';

import 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState>{
  AddTaskCubit() : super(AddTaskInitialState());
  static AddTaskCubit get(context)=> BlocProvider.of(context);
  HomeRepo repo = HomeRepo();

  var title = TextEditingController();
  var description = TextEditingController();
  DateTime? selectedDate;
  onDateChanged(DateTime date){
    selectedDate = date;
    emit(AddTaskDateChangedState());
  }
  var formKey = GlobalKey<FormState>();

  addTask()async{
    if(formKey.currentState?.validate() == false) return;
    emit(AddTaskLoadingState());
    var result = await repo.createTask(title: title.text, description: description.text);
    result.fold(
        (e)=> emit(AddTaskErrorState(e)),
        (tasks)=> emit(AddTaskSuccessState(tasks))
    );
  }
}