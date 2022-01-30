import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:madinati/ui/pages/homePage.dart';
import 'package:madinati/ui/pages/loginPage.dart';

final storage = FlutterSecureStorage();
var serverAddress = "";

Future<String> get jwtOrEmpty async {
  var jwt = await storage.read(key: "jwt");
  if (jwt == null) return "";
  return jwt;
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Madinati',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: FutureBuilder(
          future: jwtOrEmpty,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            if (snapshot.data != "") {
              var str = snapshot.data as String;
              var jwt = str.split(".");

              if (jwt.length != 3) {
                return LoginPage();
              } else {
                var payload = json.decode(
                    ascii.decode(base64.decode(base64.normalize(jwt[1]))));
                if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
                    .isAfter(DateTime.now())) {
                  return HomePage(str, payload);
                } else {
                  return LoginPage();
                }
              }
            } else {
              return LoginPage();
            }
          }),
    );
  }
}
