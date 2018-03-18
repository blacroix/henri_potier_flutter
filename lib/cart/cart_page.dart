import 'package:flutter/material.dart';
import 'package:henri_potier_flutter/book.dart';
import 'package:henri_potier_flutter/cart/cart_presenter.dart';
import 'package:henri_potier_flutter/offer.dart';

class CartPage extends StatelessWidget {
  final List<Book> _books;

  CartPage(this._books);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, position) => BookRow(_books[position]),
              itemCount: _books.length,
            ),
          ),
          Container(
            color: Colors.grey[100],
            child: BooksPriceSummary(_books),
          )
        ],
      ));
}

class BooksPriceSummary extends StatefulWidget {
  final _books;

  BooksPriceSummary(this._books);

  @override
  State<StatefulWidget> createState() => BooksPriceSummaryState(_books);
}

class BooksPriceSummaryState extends State<BooksPriceSummary> {
  final CartPresenter presenter = CartPresenter();
  final _books;

  Offer _offer;

  @override
  void initState() {
    super.initState();
    presenter.fetchBestOffer(_books).then((offer) {
      setState(() {
        this._offer = offer;
      });
    });
  }

  BooksPriceSummaryState(this._books);

  @override
  Widget build(BuildContext context) {
    if (_offer == null) {
      return Container(
        alignment: AlignmentDirectional.center,
        padding: EdgeInsets.all(12.0),
        child: CircularProgressIndicator(),
      );
    } else {
      var totalPrice = presenter.calculateTotalPrice(_books);
      return Column(
        children: <Widget>[
          ListTile(
            title: Text('Book count:'),
            trailing: Text(_books.length.toString()),
          ),
          ListTile(
            title: Text('Total price:'),
            trailing: Text(
              "${totalPrice.toString()} €",
              style: TextStyle(decoration: TextDecoration.lineThrough),
            ),
          ),
          ListTile(
            title: Text('Rebate available:'),
            trailing: Text("${_offer.toString()}"),
          ),
          ListTile(
            title: Text('New total price:'),
            trailing: Text(
                "${presenter.calculateNewPrice(totalPrice, _offer)} €",
                style: TextStyle(fontWeight: FontWeight.w700)),
          ),
          Container(
            padding: EdgeInsets.all(12.0),
            child: RaisedButton(
              onPressed: () {},
              child: Text('Buy'),
              color: Colors.blue,
              textColor: Colors.white,
            ),
          )
        ],
      );
    }
  }
}

class BookRow extends StatelessWidget {
  final Book _book;

  BookRow(this._book);

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          ListTile(
            title: Text(_book.title),
            trailing: Text("${_book.price} €"),
          ),
          Divider(),
        ],
      );
}
