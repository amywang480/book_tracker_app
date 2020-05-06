import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bookshelf.dart';

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

// BOOK OBJECT
class Book {
  String title, url;
  Book(this.title, this.url);
}

// HOME PAGE
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// APP BAR
AppBar getAppBar() {
  return AppBar(
    title: Text(
      'Bibliofila',
      style: TextStyle(
        fontFamily: 'Playfair',
        fontSize: 40.0,
      ),
    ),
  );
}

// BOTTOM NAV BAR
BottomNavigationBar getNavBar() {
  return BottomNavigationBar(
    currentIndex: 0, // this will be set when a new tab is tapped
    items: [
      BottomNavigationBarItem(
        icon: new Icon(Icons.book),
        title: new Text('Add Books'),
      ),
      BottomNavigationBarItem(
        icon: new Icon(Icons.collections_bookmark),
        title: new Text('Bookshelf'),
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.star_border),
          title: Text('Ratings')
      )
    ],
  );
}

// DRAWER
Drawer getDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          height: 200,
          child: DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/logo.png"),
              ),
            ),
          ),
        ),
        Divider(
          color: Colors.red[400],
        ),
        ListTile(
          title: Text(
            'Add Books',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Courier',
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          },
        ),
        Divider(
          color: Colors.red[400],
        ),
        ListTile(
          title: Text(
            'Bookshelf',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Courier',
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Bookshelf()),
            );
          },
        ),
        Divider(
          color: Colors.red[400],
        ),
        ListTile(
          title: Text(
            'Ratings',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Courier',
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            },
        ),
        Divider(
          color: Colors.red[400],
        ),
      ],
    ),
  );
}

// ADD BOOKS
class _MyHomePageState extends State<MyHomePage> {
  List<Book> _items = new List();
  //final subject = new PublishSubject<String>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg1.jpg'),
          //colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.93), BlendMode.dstATop),
          fit: BoxFit.cover,
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        //appBar: getAppBar(),
        bottomNavigationBar: getNavBar(),
        body: Column(
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
                'insert quote',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Courier',
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
