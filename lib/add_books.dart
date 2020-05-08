import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sqflite/sqflite.dart';
import 'main.dart';

class AddBooks extends StatefulWidget {
  @override
  _AddBooksState createState() => _AddBooksState();
}

// BOOK OBJECT
class Book {
  String title, url;

  Book(this.title, this.url);
}

Column getPage() {
  return Column(
    children: <Widget>[
      SizedBox(
        height: 25,
      ),
      Image(
        image: AssetImage('assets/logo.png'),
        width: 230,
        height: 230,
      ),
      Center(
        child: Text(
          '"Insert sample quote here"\nAuthor',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Courier',
            fontSize: 25,
            //fontWeight: FontWeight.bold,
            height: 1.1,
            color: Colors.white,
          ),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Image(
        image: AssetImage('assets/book.png'),
        width: 55,
        height: 55,
        color: Colors.red[200],
      ),
      SizedBox(
        height: 30,
      ),
    ],
  );
}

InputDecoration getSearchInput() {
  return InputDecoration(
    enabledBorder: const OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white, width: 1.5),
    ),
    prefixIcon: Icon(Icons.search, color: Colors.white),
    hintText: 'Start searching',
    hintStyle: TextStyle(color: Colors.white),
    border: OutlineInputBorder(),
  );
}

class _AddBooksState extends State<AddBooks>
    with SingleTickerProviderStateMixin {
  List<Book> _items = new List();
  final subject = new PublishSubject<String>();
  bool _isLoading = false;
  AnimationController _controller;
  Animation _animation;
  FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: getAddBg(),
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Theme(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          decoration: getSearchInput(),
                          focusNode: _focusNode,
                          onChanged: (string) => (subject.add(string)),
                        ),
                      ),
                      data:
                          Theme.of(context).copyWith(primaryColor: Colors.white),
                    ),
                    _isLoading ? CircularProgressIndicator() : Container(),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(15.0),
                        itemCount: _items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Row(
                                children: <Widget>[
                                  _items[index].url != null
                                      ? Image.network(_items[index].url)
                                      : Container(),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        _items[index].title,
                                        style: TextStyle(
                                          fontFamily: 'Zilla',
                                          fontSize: 30,
                                        ),
                                        maxLines: 10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),

            ),


        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween(begin: 500.0, end: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });

    subject.stream
        .debounceTime(Duration(milliseconds: 600))
        .listen(_textChanged);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  void _textChanged(String text) {
    if (text.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      _clearList();
      return;
    }

    setState(() {
      _isLoading = true;
    });

    _clearList();

    http
        .get("https://www.googleapis.com/books/v1/volumes?q=$text")
        .then((response) => response.body)
        .then(json.decode)
        .then((map) => map["items"])
        .then((list) {
          list.forEach(_addBook);
        })
        .catchError(_onError)
        .then((e) {
          setState(() {
            _isLoading = false;
          });
        });
  }

  void _addBook(dynamic book) {
    setState(() {
      _items.add(new Book(book["volumeInfo"]["title"],
          book["volumeInfo"]["imageLinks"]["smallThumbnail"]));
    });
  }

  void _onError(dynamic d) {
    setState(() {
      _isLoading = false;
    });
  }

  void _clearList() {
    setState(() {
      _items.clear();
    });
  }
}
