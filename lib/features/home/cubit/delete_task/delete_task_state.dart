import '../../data/models/task_model.dart';

abstract class DeleteTaskState {}

class DeleteTaskInitialState extends DeleteTaskState {}

class DeleteTaskLoadingState extends DeleteTaskState {}

class DeleteTaskSuccessState extends DeleteTaskState {
  final String message;
  DeleteTaskSuccessState(this.message);
}

class DeleteTaskErrorState extends DeleteTaskState {
  String error;
  DeleteTaskErrorState(this.error);
}