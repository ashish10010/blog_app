import 'package:blog_app/core/errors/failure.dart';
import 'package:blog_app/core/errors/exeception.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/core/common/entities/users.dart';
import 'package:blog_app/features/auth/data/models/user_models.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;
  const AuthRepositoryImpl(
    this.remoteDataSource,
    this.connectionChecker,
  );

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final session = await remoteDataSource.currentUserSession;
        if (session == null) {
          return left(Failure('User not logged in!'));
        }
        return right(UserModel(
          id: session.user.id,
          name: '',
          email: session.user.email ?? '',
        ));
      }
      final user = await remoteDataSource.getcurrentUserData();
      if (user == null) {
        return (left(
          Failure('User not logged in!'),
        ));
      }
      return right(user);
    } on ServerException catch (e) {
      return (left(
        Failure(
          e.message,
        ),
      ));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithEmailandPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailandPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure("No internet Connection!"));
      }
      final user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
