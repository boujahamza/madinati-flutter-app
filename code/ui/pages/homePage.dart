import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:madinati/ui/pages/eventsPage.dart';
import 'package:madinati/ui/pages/locationsPage.dart';
import 'package:madinati/ui/pages/newsPage.dart';
import 'package:madinati/ui/pages/weatherPage.dart';
import 'package:madinati/ui/pages/welcomePage.dart';

class HomePage extends StatefulWidget {
  HomePage(this.jwt, this.payload);

  factory HomePage.fromBase64(String jwt) => HomePage(
      jwt,
      json.decode(
          ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));

  final String jwt;
  final Map<String, dynamic> payload;
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    var items = [
      WelcomePage(username: widget.payload["username"]),
      WeatherPage(),
      NewsPage(),
      LocationsPage()
    ];
    return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.yellow[600],
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_rounded,
                ),
                label: "Acceuil"),
            BottomNavigationBarItem(
                icon: Icon(Icons.wb_sunny_rounded), label: 'Meteo'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.feed_rounded,
                ),
                label: "Actu"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_pin_circle_rounded,
                ),
                label: "Lieux"),
          ],
          currentIndex: _selectedIndex,
          onTap: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
        ),
        body: Column(
          children: [
            SizedBox(
              height: 24,
            ),
            items.elementAt(_selectedIndex)
          ],
        ));
  }
}
