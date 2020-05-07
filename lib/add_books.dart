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

class _AddBooksState extends State<AddBooks> {
  List<Book> _items = new List();
  final subject = new PublishSubject<String>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Column(
            children: <Widget>[
              Image(
                image: AssetImage('assets/logo.png'),
                width: 270,
                height: 270,
              ),
              Center(
                child: Text(
                  '"Insert sample quote here"',
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
              TextField(
                decoration: InputDecoration(
                  hintText: 'Start searching',
                ),
                onChanged: (string) => (subject.add(string)),
              ),
              _isLoading ? CircularProgressIndicator() : Container(),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  itemCount: _items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            _items[index].url != null
                                ? Image.network(_items[index].url)
                                : Container(),
                            Flexible(
                              child: Text(
                                _items[index].title,
                                maxLines: 10,
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
    );
  }

  @override
  void initState() {
    super.initState();
    subject.stream
        .debounceTime(Duration(milliseconds: 600))
        .listen(_textChanged);
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
