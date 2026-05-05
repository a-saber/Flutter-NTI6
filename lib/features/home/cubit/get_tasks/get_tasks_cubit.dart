import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nti6/features/home/cubit/get_tasks/get_tasks_state.dart';
import 'package:flutter_nti6/features/home/data/repo/home_repo.dart';

class GetTasksCubit extends Cubit<GetTasksState>{
  GetTasksCubit() : super(GetTasksInitialState());
  static GetTasksCubit get(context)=> BlocProvider.of(context);
  HomeRepo repo = HomeRepo();
  getTasks()async{
    emit(GetTasksLoadingState());
    var result = await repo.getTasks();
    result.fold(
        (e)=> emit(GetTasksErrorState(e)),
        (tasks)=> emit(GetTasksSuccessState(tasks))
    );
  }
}