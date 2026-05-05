import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nti6/features/home/data/models/task_model.dart';
import 'package:flutter_nti6/features/home/data/repo/home_repo.dart';
import 'package:image_picker/image_picker.dart';

import 'update_task_state.dart';

class UpdateTaskCubit extends Cubit<UpdateTaskState>{
  final TaskModel taskModel;
  UpdateTaskCubit(this.taskModel) : super(UpdateTaskInitialState()){
    title.text = taskModel.title ??'';
    description.text = taskModel.description ??'';
  }
  static UpdateTaskCubit get(context)=> BlocProvider.of(context);
  HomeRepo repo = HomeRepo();

  var title = TextEditingController();
  var description = TextEditingController();
  var formKey = GlobalKey<FormState>();

  XFile? selectedImage;
  pickImage()async{
    final picker = ImagePicker();
// Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if(image != null) {
      selectedImage = image;
      emit(UpdateTaskImagePickedState());
    }
  }

  updateTask()async{
    if(formKey.currentState?.validate() == false) return;
    emit(UpdateTaskLoadingState());
    taskModel.title = title.text;
    taskModel.description = description.text;
    var result = await repo.updateTask(
      taskModel: taskModel,
      fileImagePath: selectedImage?.path
    );
    result.fold(
        (e)=> emit(UpdateTaskErrorState(e)),
        (tasks)=> emit(UpdateTaskSuccessState(tasks))
    );
  }
}