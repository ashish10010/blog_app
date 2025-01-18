import 'package:blog_app/core/errors/failure.dart';
import 'package:blog_app/core/usecase/use_case.dart';
import 'package:blog_app/core/common/entities/users.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authrepository;
  CurrentUser(this.authrepository);
  @override
  Future<Either<Failure, User>> call(NoParams params) {
    return authrepository.currentUser();
  }
}
