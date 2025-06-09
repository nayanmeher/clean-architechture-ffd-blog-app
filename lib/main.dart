import 'package:clean_architechtrue_blog_app/core/theme/theme.dart';
import 'package:clean_architechtrue_blog_app/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:clean_architechtrue_blog_app/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:clean_architechtrue_blog_app/feature/auth/domain/usecases/user_sign_up.dart';
import 'package:clean_architechtrue_blog_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_architechtrue_blog_app/feature/auth/presentation/pages/login_page.dart';
import 'package:clean_architechtrue_blog_app/init_dependency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/secrates/app_secrate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependency2();
  // final supabase = await Supabase.initialize(
  //     url: AppSecrets.supabseUrl, anonKey: AppSecrets.anonKey);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
          create: (_) => serviceLocator<AuthBloc>())
          // create: (_) => AuthBloc(
          //     userSignup: UserSignup(AuthRepositoryImpl(
          //         AuthRemoteDataSourceImpl(supabase.client))))),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,
      home: const SignInPage(),
    );
  }
}
