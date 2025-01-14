import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/errors.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUpWithEmailandPassword({
    required String name,
    required String email,
    required String password,
  });

    Future<Either<Failure, String>> loginWithEmailandPassword({
    required String email,
    required String password,
  });
}
