// To parse this JSON data, do
//     final news = newsFromJson(jsonString);
// News newsFromJson(String str) => News.fromJson(json.decode(str));

class News {
  List<Article> articles;

  News({
    required this.articles,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
        articles: List<Article>.from(
            json["articles"].map((x) => Article.fromJson(x))),
      );
}

class Article {
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? content;

  Article({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        content: json["content"],
      );
}
