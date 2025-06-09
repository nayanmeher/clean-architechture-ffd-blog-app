import 'dart:developer';

import 'package:clean_architechtrue_blog_app/feature/auth/domain/entity/user.dart';
import 'package:clean_architechtrue_blog_app/feature/auth/domain/usecases/user_login.dart';
import 'package:clean_architechtrue_blog_app/feature/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;
  final UserLogin _userLogin;

  AuthBloc({required UserLogin userLogin, required UserSignup userSignup})
      : _userSignup = userSignup,
        _userLogin = userLogin,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async{
      log('name : ${event.name}');
      emit(AuthLoading());
      final resp = await _userSignup(UserSignUpParams(names: event.name,
          email: event.email, password: event.password));
      resp.fold((l){
        emit(AuthFailure(l.message));
      }, (r){
        emit(AuthSuccess(r));
      });
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async{
      emit(AuthLoading());
      final resp = await _userLogin(UserLoginParams(
          email: event.email, password: event.password));
      resp.fold((l){
        emit(AuthFailure(l.message));
      }, (r){
        emit(AuthSuccess(r));
      });
  }
}
