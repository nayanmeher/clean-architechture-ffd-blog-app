import 'package:clean_architechtrue_blog_app/core/common/widget/loader.dart';
import 'package:clean_architechtrue_blog_app/core/theme/app_pallete.dart';
import 'package:clean_architechtrue_blog_app/core/utils/show_snackBar.dart';
import 'package:clean_architechtrue_blog_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_architechtrue_blog_app/feature/auth/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/auth_form_field.dart';
import '../widgets/auth_gradient_button.dart';

class SignInPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (_) => SignInPage());

  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if(state is AuthFailure){
              showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if(state is AuthLoading){
              return Loader();
            }
            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign In.',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  AuthFormField(
                    hintText: 'Email',
                    textEditingController: emailController,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  AuthFormField(
                    hintText: 'Password',
                    textEditingController: passwordController,
                    isObscureText: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AuthGradientButton(
                    buttonLabel: 'Sign In',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(AuthLogin(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim()));
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context, SignupPage.route());
                    },
                    child: RichText(
                      text: TextSpan(
                          text: 'Don\'t have an account?',
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleMedium,
                          children: [
                            TextSpan(
                                text: ' Sign Up',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                    color: AppPallete.gradient2,
                                    fontWeight: FontWeight.w600))
                          ]),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
