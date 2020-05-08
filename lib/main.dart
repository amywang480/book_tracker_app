import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bookshelf.dart';
import 'ratings.dart';
import 'add_books.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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

// BOTTOM NAV BAR
List<BottomNavigationBarItem> getIcons() {
  return [
      BottomNavigationBarItem(
        icon: new Icon(Icons.book, color: Colors.black),
        title: new Text('Add Books', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.cyan[200],
      ),
      BottomNavigationBarItem(
        icon: new Icon(Icons.inbox, color: Colors.black),
        title: new Text('Bookshelf', style: TextStyle(color: Colors.black)),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.star_border, color: Colors.black),
        title: Text('Ratings', style: TextStyle(color: Colors.black)),
      ),
    ];
}

BoxDecoration getAddBg() {
  return BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/AddBooksBg.png'),
        fit: BoxFit.cover,
      ),
  );
}

BoxDecoration getBg() {
  return BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/bg.jpg'),
      fit: BoxFit.cover,
    ),
  );
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedPage = 0;

  final pageOptions = [
    AddBooks(),
    Bookshelf(),
    Ratings(),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      //decoration: getBg(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.shifting,
              currentIndex: _currentIndex,
              items: getIcons(),
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
        body: pageOptions[_currentIndex],
      ),
    );
  }
}
