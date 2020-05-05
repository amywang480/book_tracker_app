import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: MyHomePage(title: 'Bibliofila'),
    );
  }
}

// HOME PAGE

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.title,
            style: TextStyle(
              fontFamily: 'Playfair',
              fontSize: 35.0,
            ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 200,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/logo.png"),
                    //fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.red[400],
            ),
            ListTile(
              title: Text('Add Books'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              color: Colors.red[400],
            ),
            ListTile(
              title: Text('Bookshelf'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              color: Colors.red[400],
            ),
            ListTile(
              title: Text('Ratings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              color: Colors.red[400],
            ),
          ],
        ),
      ),
    );
  }
}
