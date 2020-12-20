import 'author.dart';
import 'category.dart';
import 'cover.dart';

class Article {
  final int readCount;
  final String id;
  final String title;
  final Author author;
  final String content;
  final String createdAt;
  final Cover cover;
  final Category category;

  Article({
    this.readCount,
    this.id,
    this.title,
    this.author,
    this.content,
    this.createdAt,
    this.cover,
    this.category,
  });

  factory Article.fromJson(Map<String, dynamic> data) {
    return Article(
      readCount: data['read_count'],
      id: data['_id'],
      title: data['title'],
      author: Author.fromJson(data['author']),
      content: data['content'],
      createdAt: data['createdAt'],
      cover: Cover.fromJson(data['cover']),
      category: Category.fromJson(data['category']),
    );
  }
}
