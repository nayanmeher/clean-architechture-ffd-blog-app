import 'package:clean_architechtrue_blog_app/feature/auth/domain/entity/user.dart';

class UserModel extends User{
  UserModel({required super.email, required super.name, required super.id});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(email: map['email'], name: map['name'], id: map['id']);
  }
}