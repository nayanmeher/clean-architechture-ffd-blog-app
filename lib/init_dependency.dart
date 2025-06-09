import 'dart:developer';

import 'package:clean_architechtrue_blog_app/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:clean_architechtrue_blog_app/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:clean_architechtrue_blog_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:clean_architechtrue_blog_app/feature/auth/domain/usecases/user_login.dart';
import 'package:clean_architechtrue_blog_app/feature/auth/domain/usecases/user_sign_up.dart';
import 'package:clean_architechtrue_blog_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/secrates/app_secrate.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependency() async {
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabseUrl, anonKey: AppSecrets.anonKey);
  serviceLocator.registerLazySingleton(() => supabase.client);
  _initAuth();
  // If we have to get one instance for all the time we need to use registerLazySingleton()
}

void _initAuth() {
  //if we have to get new instance whenever call servicelocator then we need to use registerFactory()
  serviceLocator.registerFactory<AuthRemoteDataSource>(
          () => AuthRemoteDataSourceImpl(serviceLocator()));
  serviceLocator.registerFactory<AuthRepository>(
          () => AuthRepositoryImpl(serviceLocator()));
  serviceLocator.registerFactory(() => UserSignup(serviceLocator()));
  serviceLocator.registerFactory(() => UserLogin(serviceLocator()));
  serviceLocator
      .registerFactory(() => AuthBloc(userSignup: serviceLocator(), userLogin: serviceLocator()));

  final client = serviceLocator<SupabaseClient>();
  final ds = AuthRemoteDataSourceImpl(client);
  final repo = AuthRepositoryImpl(ds);
  final signUpUseCase = UserSignup(repo);
  final logInUseCase = UserLogin(repo);
  final bloc = AuthBloc(userSignup: signUpUseCase, userLogin: logInUseCase);
  log("✅ All instances created: $bloc");
  log("AuthBloc test: ${serviceLocator<AuthBloc>()}");
}


Future<void> initDependency2() async {
  // Initialize Supabase
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabseUrl,
    anonKey: AppSecrets.anonKey,
  );

  // Register Supabase client
  serviceLocator.registerLazySingleton(() => supabase.client);

  // Register AuthRemoteDataSource
  serviceLocator.registerFactory<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(serviceLocator()), // SupabaseClient injected
  );

  // Register AuthRepository
  serviceLocator.registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(serviceLocator()), // AuthRemoteDataSource injected
  );

  // Register UserSignup use case
  serviceLocator.registerFactory<UserSignup>(
        () => UserSignup(serviceLocator()), // AuthRepository injected
  );
  serviceLocator.registerFactory<UserLogin>(
        () => UserLogin(serviceLocator()), // AuthRepository injected
  );


  // Register AuthBloc
  serviceLocator.registerFactory<AuthBloc>(
        () => AuthBloc(userSignup: serviceLocator(), userLogin: serviceLocator()), // UserSignup injected
  );
}
