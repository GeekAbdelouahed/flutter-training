import 'cover.dart';
import 'author.dart';

class Article {
  final int readCount;
  final String id;
  final String title;
  final Author author;
  final String content;
  final String createdAt;
  final Cover cover;

  Article({
    this.readCount,
    this.id,
    this.title,
    this.author,
    this.content,
    this.createdAt,
    this.cover,
  });

  factory Article.fromJson(Map<String, dynamic> data) {
    return Article(
      readCount: data['read_count'],
      id: data['_id'],
      title: data['title'],
      author: Author.fromJson(data['author']),
      content: data['contant'],
      createdAt: data['createdAt'],
      cover: Cover.fromJson(data['cover']),
    );
  }
}
