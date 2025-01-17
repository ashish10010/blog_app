import 'package:blog_app/core/errors/failure.dart';
import 'package:blog_app/core/usecase/use_case.dart';
import 'package:blog_app/features/auth/domain/entities/users.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogin implements UseCase<User, UserLoginParams> {
  final AuthRepository authRepository;
  const UserLogin(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return authRepository.loginWithEmailandPassword(
        email: params.email, password: params.password,
        );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({required this.email, required this.password});
}
