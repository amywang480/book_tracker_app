import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class Ratings extends StatefulWidget {
  @override
  _RatingsState createState() => _RatingsState();
}

class _RatingsState extends State<Ratings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: getBg(),
      child: Column(
        children: <Widget>[
          Text('ratings'),
          Image(
            image: AssetImage('assets/quote.png'),
          ),
        ],
      ),
    );
  }
}