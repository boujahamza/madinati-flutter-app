import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:madinati/core/models/locationPost_model.dart';
import 'package:madinati/core/services/fetchLocationPosts.dart';
import 'package:madinati/ui/pages/postLocation.dart';

class LocationsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  late Future<List<LocationPost>> futureLocationPostsList;

  @override
  void initState() {
    super.initState();
    futureLocationPostsList = fetchLocationPosts();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Stack(children: [
      Container(
          height: height - 80,
          child: FutureBuilder<List<LocationPost>>(
              future: futureLocationPostsList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, int) {
                        return Column(children: [
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  padding: EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      Row(children: [
                                        Text(
                                          snapshot.data![int].username,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Text(" est ",
                                            style: TextStyle(fontSize: 20)),
                                        Text(snapshot.data![int].mood,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20)),
                                        Text(" à ",
                                            style: TextStyle(fontSize: 20)),
                                        Text(snapshot.data![int].location,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20))
                                      ]),
                                      SizedBox(height: 20),
                                      Text(snapshot.data![int].desc,
                                          style: TextStyle(fontSize: 13)),
                                    ],
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                  ))),
                          Divider()
                        ]);
                      });
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })),
      Positioned(
        bottom: 20,
        right: 20,
        child: GestureDetector(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.yellow[700]),
              child: Center(child: Icon(Icons.add, color: Colors.white)),
            ),
            onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PostLocation()))
                    .then((value) {
                  setState(() {
                    // refresh state of Page1
                  });
                })),
      ),
    ]);
  }
}
