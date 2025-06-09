import 'package:clean_architechtrue_blog_app/feature/auth/domain/entity/user.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';

abstract interface class AuthRepository{
  Future<Either<Failure, User>> signupWithEmailPassword({
    required String name,
    required String email,
    required String password
});
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password
  });
}