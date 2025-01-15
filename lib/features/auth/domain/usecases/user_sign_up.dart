import 'package:blog_app/core/errors/failure.dart';
import 'package:blog_app/core/usecase/use_case.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCase<String, UserSignUpParams> {
  final AuthRepository authrepo;
  const UserSignUp(this.authrepo);
  @override
  Future<Either<Failure, String>> call(UserSignUpParams params) async {
   return await authrepo.signUpWithEmailandPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String name;
  final String password;

  UserSignUpParams({
    required this.email,
    required this.name,
    required this.password,
  });
}
