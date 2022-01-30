import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:madinati/constants.dart';
import 'package:madinati/core/models/articleList_model.dart';
import 'package:madinati/core/models/newsItem_model.dart';

import 'articlePage.dart';

class NewsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewsPageState();
}

Future<ArticleList> fetchArticleList() async {
  final response =
      await http.get(Uri.parse('https://madinati-news-service.herokuapp.com/'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return ArticleList.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Articles');
  }
}

class _NewsPageState extends State<NewsPage> {
  late Future<ArticleList> futureArticleList;

  @override
  void initState() {
    super.initState();
    futureArticleList = fetchArticleList();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    var articleItem =
        (imglink, link, title, shortdesc, fulldesc, date) => Padding(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    child: Stack(
                      children: [
                        Center(
                            child: Image.network(
                          imglink,
                          scale: 0.75,
                        )),
                        Positioned.fill(
                            child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black,
                              Colors.transparent,
                            ],
                          )),
                        )),
                        Positioned(
                            width: 300,
                            top: 90,
                            child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(date,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: Colors.yellow[700])),
                                      SizedBox(height: 10),
                                      Text(
                                        title,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ])))
                      ],
                    ),
                  )),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ArticlePage(
                      imglink: imglink,
                      title: title,
                      date: date,
                      shortdesc: shortdesc,
                      fulldesc: fulldesc))),
            ));

    return Expanded(
        child: FutureBuilder<ArticleList>(
            future: futureArticleList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      NewsItem article =
                          new NewsItem.fromJson(snapshot.data!.articles[index]);
                      return articleItem(
                          article.imageLink,
                          article.link,
                          article.title,
                          article.shortDesc,
                          article.fullDesc,
                          article.date);
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
