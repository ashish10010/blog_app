import 'dart:io';
import 'package:blog_app/core/errors/failure.dart';
import 'package:blog_app/core/usecase/use_case.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import '../entities/blog.dart';

class UploadBlog implements UseCase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;
  UploadBlog(this.blogRepository);
  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      posterId: params.posterId,
      topics: params.topics,
    );
  }
}

class UploadBlogParams {
  final String posterId;
  final String title;
  final List<String> topics;
  final String content;
  final File image;

  UploadBlogParams({
    required this.posterId,
    required this.title,
    required this.topics,
    required this.content,
    required this.image,
  });
}
