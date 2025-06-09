import 'package:clean_architechtrue_blog_app/core/error/failure.dart';
import 'package:clean_architechtrue_blog_app/feature/auth/domain/repository/auth_repository.dart';

import 'package:fpdart/src/either.dart';

import '../../../../core/usecase/usecase.dart';
import '../entity/user.dart';

class UserLogin implements UseCase<User, UserLoginParams> {
  AuthRepository authRepository;

  UserLogin(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return await authRepository.loginWithEmailPassword(
        email: params.email, password: params.password);
  }
}

class UserLoginParams {
  final String email;
  final String password;

  const UserLoginParams({
    required this.email,
    required this.password,
  });
}
