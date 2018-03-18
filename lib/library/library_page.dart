import 'package:flutter/material.dart';
import 'package:henri_potier_flutter/book.dart';

import 'book_list.dart';
import 'app_bar_cart.dart';
import 'package:henri_potier_flutter/cart/cart_page.dart';

class LibraryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final booksInCart = List<Book>();
    final _onCartClick = () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CartPage(booksInCart)));
    };

    final _appBarCart = AppBarCart(_onCartClick);

    final _onAddToCartClick = (book) {
      booksInCart.add(book);
      _appBarCart.add();
    };

    return Scaffold(
        appBar: AppBar(
          title: Text('Henri Potier Library'),
          actions: [_appBarCart],
        ),
        body: BookList(_onAddToCartClick));
  }
}
