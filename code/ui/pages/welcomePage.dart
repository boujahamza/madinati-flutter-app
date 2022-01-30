import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:madinati/ui/components/stdButton.dart';

import '../../main.dart';
import 'loginPage.dart';

class WelcomePage extends StatefulWidget {
  String username;
  WelcomePage({required this.username});
  @override
  State<StatefulWidget> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final username = widget.username;
    return Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Bonjour $username", style: TextStyle(fontSize: 25)),
            SizedBox(
              height: 20,
            ),
            StdButton(
                function: () async {
                  await storage.delete(key: "jwt");
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                text: 'se deconnecter'),
            SizedBox(height: 30),
            Text(
              "Decouvrez votre ville!",
              style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
          ],
        ));
  }
}
