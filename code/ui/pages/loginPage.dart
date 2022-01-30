import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';
import 'homePage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var signupButton, signinButton;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    signinButton = TextButton(
        onPressed: () async {
          var username = _usernameController.text;
          var password = _passwordController.text;
          var jwt;
          try {
            jwt = await attemptSignin(username, password);
          } catch (e) {
            jwt = null;
          }
          if (jwt != null) {
            storage.write(key: "jwt", value: jwt);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage.fromBase64(jwt)));
          } else {
            displayDialog(context, "Erreur", "La connexion a echouée");
          }
        },
        child: Text(
          "Connexion",
          style: TextStyle(color: Colors.yellow[700]),
        ));
    signupButton = TextButton(
        onPressed: () async {
          var username = _usernameController.text;
          var password = _passwordController.text;

          if (username.length < 4)
            displayDialog(context, "Invalid Username",
                "The username should be at least 4 characters long");
          else if (password.length < 4)
            displayDialog(context, "Invalid Password",
                "The password should be at least 4 characters long");
          else {
            var res;
            try {
              res = await attemptSignup(username, password);
            } catch (e) {
              res = 409;
            }
            if (res == 201)
              displayDialog(
                  context, "Success", "The user was created. Log in now.");
            else if (res == 409)
              displayDialog(context, "That username is already registered",
                  "Please try to sign up using another username or log in if you already have an account.");
            else {
              displayDialog(context, "Error", "An unknown error occurred.");
            }
          }
        },
        child:
            Text("Inscription", style: TextStyle(color: Colors.yellow[700])));
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
                child: Container(
      child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Bienvenue à Madinati!",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nom d\'utilisateur',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mot de passe',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                signinButton,
                SizedBox(
                  width: 10,
                ),
                signupButton
              ]),
            ],
          )),
      color: Colors.white,
    ))));
  }

  void displayDialog(BuildContext context, String title, String text) =>
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  Future<String?> attemptSignin(String username, String password) async {
    var res = await http.post(
        Uri.parse("https://madinati-auth-service.herokuapp.com/signin"),
        body: {"username": username, "password": password});
    if (res.statusCode == 200) return res.body;
    return null;
  }

  Future<int> attemptSignup(String username, String password) async {
    var res = await http.post(
        Uri.parse("https://madinati-auth-service.herokuapp.com/signup"),
        body: {"username": username, "password": password});
    return res.statusCode;
  }
}
