import 'package:clean_architechtrue_blog_app/core/error/failure.dart';
import 'package:clean_architechtrue_blog_app/core/usecase/usecase.dart';
import 'package:clean_architechtrue_blog_app/feature/auth/domain/entity/user.dart';
import 'package:clean_architechtrue_blog_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class UserSignup implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;

  UserSignup(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authRepository.signupWithEmailPassword(
        name: params.names, email: params.email, password: params.password);
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String names;

  const UserSignUpParams({
    required this.email,
    required this.password,
    required this.names,
  });
}
