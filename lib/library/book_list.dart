import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'package:henri_potier_flutter/book.dart';
import 'package:http/http.dart' as http;

import '../book_page.dart';

class BookList extends StatefulWidget {
  final _onAddToCartClick;

  BookList(this._onAddToCartClick);

  @override
  State<StatefulWidget> createState() => _BookListState(_onAddToCartClick);
}

class _BookListState extends State<BookList> {
  final _onAddToCartClick;

  List<Book> _books = [];
  bool _loading = true;

  _BookListState(this._onAddToCartClick);

  @override
  void initState() {
    super.initState();
    fetchBooks().then((books) {
      setState(() {
        _loading = false;
        this._books = books;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Container(
        alignment: AlignmentDirectional.center,
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.builder(
        itemCount: _books.length,
        itemBuilder: (context, position) =>
            BookRow(_books[position], _onAddToCartClick),
      );
    }
  }
}

class BookRow extends StatelessWidget {
  final Book _book;
  final _onAddToCartClick;

  BookRow(this._book, this._onAddToCartClick);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Image.network(_book.cover),
          title: Text(_book.title),
          trailing: _buildOnAddToCartTap(),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => BookPage(_book)));
          },
        ),
        Divider()
      ],
    );
  }

  _buildOnAddToCartTap() => InkWell(
        onTap: () => this._onAddToCartClick(_book),
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: Icon(Icons.add_shopping_cart),
        ),
      );
}

Future<List<Book>> fetchBooks() async {
  final response = await http.get('http://henri-potier.xebia.fr/books');
  final json = JSON.decode(response.body);
  final books = List<Book>();
  for (final jsonBook in json) {
    books.add(Book.fromJson(jsonBook));
  }
  return books;
}
