part of 'models.dart';

class News extends Equatable {
  final String author;
  final String title;
  final String description;
  final String urlToImage;
  final String publishedAt;
  final String content;

  News(
      {@required this.author,
      @required this.title,
      @required this.description,
      @required this.urlToImage,
      @required this.publishedAt,
      @required this.content});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
        author: json['author'],
        title: json['title'],
        description: json['description'],
        urlToImage: json['urlToImage'],
        publishedAt: json['publishedAt'],
        content: json['content']);
  }

  @override
  List<Object> get props =>
      [author, title, description, urlToImage, publishedAt, content];
}
