import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ArticlePage extends StatelessWidget {
  final imglink;
  final title;
  final date;
  final shortdesc;
  final fulldesc;

  ArticlePage(
      {required this.imglink,
      required this.title,
      required this.date,
      required this.shortdesc,
      required this.fulldesc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                imglink,
                scale: 0.5,
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(date),
                SizedBox(
                  height: 10,
                ),
                Text(shortdesc,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(
                  height: 10,
                ),
                Text(fulldesc.toString())
              ],
            ),
          )
        ],
      )),
    );
  }
}
