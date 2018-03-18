import 'package:flutter/material.dart';
import 'package:henri_potier_flutter/book.dart';

class BookPage extends StatelessWidget {
  final Book _book;

  BookPage(this._book);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 24.0, bottom: 12.0),
              child: Image.network(
                _book.cover,
                width: 300.0,
                height: 300.0,
              )),
          Container(
            padding: EdgeInsets.all(12.0),
            child: Text("${_book.title} (${_book.price} €)"),
          ),
          Container(
            padding: EdgeInsets.all(12.0),
            child: Text(_book.synopsis[0]),
          ),
        ],
      ),
    );
  }
}
