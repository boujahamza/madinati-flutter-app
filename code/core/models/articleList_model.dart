class ArticleList {
  final List<dynamic> articles;

  ArticleList({required this.articles});

  factory ArticleList.fromJson(Map<String, dynamic> json) {
    return ArticleList(
      articles: json['articles'],
    );
  }
}
