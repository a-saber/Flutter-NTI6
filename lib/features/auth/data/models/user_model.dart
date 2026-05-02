class UserModel{
  String? id;
  String? imagePath;
  String? username;

  UserModel({this.id, this.imagePath, this.username});
  UserModel.fromJson(Map<String, dynamic> userMap){
    id = userMap['id'];
    imagePath = userMap['image_path'];
    username= userMap['username'];
  }
}