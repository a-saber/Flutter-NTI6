import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nti6/features/home/data/models/task_model.dart';
import 'package:flutter_nti6/features/home/data/repo/home_repo.dart';

import 'delete_task_state.dart';

class DeleteTaskCubit extends Cubit<DeleteTaskState>{
  final TaskModel taskModel;
  DeleteTaskCubit(this.taskModel) : super(DeleteTaskInitialState());
  static DeleteTaskCubit get(context)=> BlocProvider.of(context);
  HomeRepo repo = HomeRepo();

  deleteTask()async{
    emit(DeleteTaskLoadingState());
    var result = await repo.deleteTask(
      taskModel: taskModel
    );
    result.fold(
        (e)=> emit(DeleteTaskErrorState(e)),
        (tasks)=> emit(DeleteTaskSuccessState(tasks))
    );
  }
}