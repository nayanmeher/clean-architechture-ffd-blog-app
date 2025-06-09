import 'dart:developer';

import 'package:clean_architechtrue_blog_app/core/error/exception.dart';
import 'package:clean_architechtrue_blog_app/feature/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUpWithEmailPassword(
      {required String name, required String email, required String password});

  Future<UserModel> loginUpWithEmailPassword(
      {required String email, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<UserModel> loginUpWithEmailPassword(
      {required String email, required String password}) async{
    try {
      // log('name : $name, email: $email, password : $password');
      final resp = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      log('Register user : ${resp.user}');
      if (resp.user == null) {
        throw ServerException('User is null');
      } /*else {
        await supabaseClient.auth.updateUser(UserAttributes(data: {
          "name": name,
        }));
      }*/
      return UserModel.fromMap(resp.user!.toJson());
    } catch (e) {
      log('loginUpWithEmailPassword: Exception : $e',
          name: 'AuthRemoteDataSourceImpl');
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      log('name : $name, email: $email, password : $password');
      final resp = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {
          "name": name,
        },
      );
      log('Register user : ${resp.user}');
      if (resp.user == null) {
        throw ServerException('User is null');
      } /*else {
        await supabaseClient.auth.updateUser(UserAttributes(data: {
          "name": name,
        }));
      }*/
      return UserModel.fromMap(resp.user!.toJson());
    } catch (e) {
      log('signUpWithEmailPassword: Exception : $e',
          name: 'AuthRemoteDataSourceImpl');
      throw ServerException(e.toString());
    }
  }
}
