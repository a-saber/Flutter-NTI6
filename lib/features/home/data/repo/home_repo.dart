import 'package:dartz/dartz.dart';
import 'package:flutter_nti6/features/home/data/models/task_model.dart';

import '../../../../core/network/api_helper.dart';
import '../../../../core/network/end_points.dart';

// CRUD
class HomeRepo {
  Future<Either<String, List<TaskModel>>> getTasks() async {
    var result =
        await ApiHelper.get(endPoint: EndPoints.myTasks, isProtected: true);
    return result.fold((errorMsg) {
      return left(errorMsg);
    }, (map) {
      GetTasksResponseModel responseModels =
          GetTasksResponseModel.fromJson(map);
      return right(responseModels.tasks ?? []);
    });
  }

  Future<Either<String, String>> createTask({
    required String title,
    required String description,
  }) async {
    var taskModel = TaskModel(title: title, description: description);
    var result = await ApiHelper.post(
        endPoint: EndPoints.newTask,
        data: taskModel.toJson(),
        isProtected: true);
    return result.fold((error) => left(error), (map) {
      return right(map['message']);
    });
  }

  Future<Either<String, String>> updateTask({required TaskModel taskModel}) async {
    var result = await ApiHelper.put(
        endPoint: EndPoints.updateTask(taskId: taskModel.id),
        data: taskModel.toJson(),
        isProtected: true
    );
    return result.fold((error) => left(error), (map) {
      return right(map['message']);
    });
  }

  Future<Either<String, String>> deleteTask({required TaskModel taskModel}) async {
    var result = await ApiHelper.delete(
        endPoint: EndPoints.updateTask(taskId: taskModel.id),
        isProtected: true
    );
    return result.fold((error) => left(error), (map) {
      return right(map['message']);
    });
  }
}
