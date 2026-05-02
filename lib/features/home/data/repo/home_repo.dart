import '../../../../core/network/api_helper.dart';
import '../../../../core/network/end_points.dart';

class HomeRepo{
  getTasks()async{

    var result = await ApiHelper.get(
        endPoint: EndPoints.myTasks,
        isProtected: true

    );
    result.fold(
            (errorMsg){

        },
            (map){

        }
    );



  }
}