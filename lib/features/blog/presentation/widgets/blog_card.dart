import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_viewer_page.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/blog.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;
  const BlogCard({super.key, required this.blog, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          BlogViewerPage.route(blog),
        );
      },
      child: Container(
        height: 200,
        margin: const EdgeInsets.all(16).copyWith(
          bottom: 4,
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: blog.topics
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Chip(
                              label: Text(e),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Text(
                  blog.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ],
            ),

            // const SizedBox(height: 50,),
            Text(
              '${calculateReadingTime(blog.content)}',
            ),
          ],
        ),
      ),
    );
  }
}
