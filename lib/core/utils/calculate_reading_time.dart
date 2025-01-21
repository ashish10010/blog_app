int calculateReadingTime(String content) {
  final wordCount = content.split(RegExp(r'\s+')).length;
  final readingTime = 225 / wordCount;
  return readingTime.ceil();
}
