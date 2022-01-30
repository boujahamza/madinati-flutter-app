import 'dart:convert';

import 'package:madinati/constants.dart';
import 'package:madinati/core/models/locationPost_model.dart';
import 'package:http/http.dart' as http;

Future<List<LocationPost>> fetchLocationPosts() async {
  final response =
      await http.get(Uri.parse('https://madinati-post-service.herokuapp.com/'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<dynamic> rawList = jsonDecode(response.body);
    List<LocationPost> postList = [];
    for (var e in rawList) postList.add(LocationPost.fromJson(e));

    return postList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load posts');
  }
}
