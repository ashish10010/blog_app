import 'package:blog_app/features/auth/domain/entities/users.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailandPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> loginWithEmailandPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> currentUser();
}
