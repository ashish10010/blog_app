import 'dart:io';

import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;
  BlogBloc(this.uploadBlog) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUploadE>(_onBlogUpload);
  }

  void _onBlogUpload(BlogUploadE event, Emitter<BlogState> emit) async {
    final result = await uploadBlog(UploadBlogParams(
      posterId: event.posterId,
      title: event.title,
      topics: event.topics,
      content: event.content,
      image: event.image,
    ));

    result.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(BlogSucess()),
    );
  }
}
