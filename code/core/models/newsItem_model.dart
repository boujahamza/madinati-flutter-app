class NewsItem {
  final String title;
  final String imageLink;
  final String shortDesc;
  final fullDesc;
  final String link;
  final String date;

  NewsItem({
    required this.title,
    required this.imageLink,
    required this.shortDesc,
    required this.fullDesc,
    required this.link,
    required this.date,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
        title: json['title'],
        imageLink: json['imageLink'],
        shortDesc: json['shortDesc'],
        fullDesc: json['fullDesc'],
        link: json['link'],
        date: json['date']);
  }
}
