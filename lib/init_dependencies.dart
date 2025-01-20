import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_login.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/secrets/app_secrets.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);

  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  //datasource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator<SupabaseClient>(),
      ),
    )
    //authrepository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator<AuthRemoteDataSource>(),
      ),
    )
    //usecases
    ..registerFactory(
      () => UserSignUp(
        serviceLocator<AuthRepository>(),
      ),
    )
    ..registerFactory(
      () => UserLogin(
        serviceLocator<AuthRepository>(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        serviceLocator<AuthRepository>(),
      ),
    )

    //authbloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator<UserSignUp>(),
        userLogin: serviceLocator<UserLogin>(),
        currentUser: serviceLocator<CurrentUser>(),
        appUserCubit: serviceLocator<AppUserCubit>(),
      ),
    );
}

void _initBlog() {
  //datasources
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(() => BlogRemoteDataSourceImpl(
          serviceLocator(),
        ))
    //repository
    ..registerFactory<BlogRepository>(() => BlogRepositoryImpl(
          serviceLocator(),
        ))
    //usecase
    ..registerFactory(() => UploadBlog(
          serviceLocator(),
        ))
    //blogbloc
    ..registerLazySingleton(() => BlogBloc(
          serviceLocator<UploadBlog>(),
        ));
}
