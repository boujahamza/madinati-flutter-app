import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:madinati/constants.dart';
import 'package:madinati/ui/components/stdButton.dart';

import '../../main.dart';

class PostLocation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PostLocationState();
}

class _PostLocationState extends State<PostLocation> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  var _dropDownValue = "Heureux";

  @override
  Widget build(BuildContext context) {
    var postButton = StdButton(
        function: () async {
          var location = _locationController.text;
          var desc = _descController.text;
          var resp;
          resp = await attemptPosting(_dropDownValue, location, desc);
          /*catch (e) {
            resp = null;
          }*/
          if (resp != null) {
            Navigator.pop(context);
          } else {
            displayDialog(context, "Erreur", "La connexion a echouée");
          }
        },
        text: "Publier");

    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Partager un lieu ou une experience",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(children: [
                      Text("Vous vous sentez: "),
                      SizedBox(width: 20),
                      DropdownButton<String>(
                        value: _dropDownValue,
                        icon: const Icon(Icons.arrow_drop_down_rounded),
                        onChanged: (String? newValue) {
                          setState(() {
                            _dropDownValue = newValue!;
                          });
                        },
                        items: <String>[
                          'Heureux',
                          'Calm',
                          'En colère',
                          'Triste'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      Text("à: "),
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Lieu',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _descController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Description',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StdButton(
                            function: () => Navigator.pop(context),
                            text: "Annuler"),
                        SizedBox(
                          width: 30,
                        ),
                        postButton,
                      ],
                    )
                  ]))),
    ));
  }
}

Future<String?> attemptPosting(
    String mood, String location, String desc) async {
  var jwt = await jwtOrEmpty();
  var username = json.decode(ascii
      .decode(base64.decode(base64.normalize(jwt.split(".")[1]))))["username"];
  var res = await http
      .post(Uri.parse("https://madinati-post-service.herokuapp.com/"), body: {
    'username': username,
    'mood': mood,
    'location': location,
    'desc': desc,
    "jwt": jwt
  });
  if (res.statusCode == 200) return res.body;
  return null;
}

Future<String> jwtOrEmpty() async {
  var jwt = await storage.read(key: "jwt");
  if (jwt == null) return "";
  return jwt;
}

void displayDialog(BuildContext context, String title, String text) =>
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(title: Text(title), content: Text(text)),
    );
