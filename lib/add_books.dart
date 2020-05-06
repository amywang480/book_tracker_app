import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddBooks extends StatefulWidget {
  @override
  _AddBooksState createState() => _AddBooksState();
}

class _AddBooksState extends State<AddBooks> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: Image(
            image: AssetImage('assets/logo.png'),
            width: 270,
            height: 270,
          ),
        ),
        Center(
          child: Text(
            '"Insert sample quote over here"',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Courier',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              height: 1.1,
            ),
          ),
        ),
        Image(
          image: AssetImage('assets/book.png'),
          width: 90,
          height: 90,
        ),
      ],
    );
  }
}