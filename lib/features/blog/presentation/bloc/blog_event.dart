part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class BlogUploadE extends BlogEvent {
  final String posterId;
  final String title;
  final List<String> topics;
  final String content;
  final File image;

  BlogUploadE({
    required this.posterId,
    required this.title,
    required this.topics,
    required this.content,
    required this.image,
  });
}
