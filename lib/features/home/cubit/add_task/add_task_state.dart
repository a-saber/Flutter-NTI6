import '../../data/models/task_model.dart';

abstract class AddTaskState {}

class AddTaskInitialState extends AddTaskState {}

class AddTaskLoadingState extends AddTaskState {}

class AddTaskDateChangedState extends AddTaskState {}

class AddTaskSuccessState extends AddTaskState {
  final String message;
  AddTaskSuccessState(this.message);
}

class AddTaskErrorState extends AddTaskState {
  String error;
  AddTaskErrorState(this.error);
}