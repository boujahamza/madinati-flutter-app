import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:madinati/ui/pages/loginPage.dart';

class StdButton extends StatelessWidget {
  var function;
  var text;

  StdButton({required this.function, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.yellow[700]),
            child: Text(
              text,
              style: TextStyle(color: Colors.white),
            )),
        onTap: function);
  }
}
