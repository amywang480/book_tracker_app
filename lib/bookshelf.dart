import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class Bookshelf extends StatefulWidget {
  @override
  _BookshelfState createState() => _BookshelfState();
}

class _BookshelfState extends State<Bookshelf> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: getDefaultBg(),
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Text('bookshelf')
          ],
        ),
      ),
    );
  }
}
