import 'package:blog_app/core/errors/failure.dart';
import 'package:blog_app/core/errors/exeception.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, String>> loginWithEmailandPassword(
      {required String email, required String password}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailandPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userId = await remoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );
      return right(userId);
    } on ServerException catch (e) {
     return left(Failure(e.message));
    }
  }
}
