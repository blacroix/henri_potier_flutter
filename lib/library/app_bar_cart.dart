import 'package:flutter/material.dart';

class AppBarCart extends StatefulWidget {
  final _onCartClick;
  final _AppBarCartState state = _AppBarCartState();

  AppBarCart(this._onCartClick);

  @override
  State<StatefulWidget> createState() => state;

  void add() => state.add();

  void onPressed() => _onCartClick();
}

class _AppBarCartState extends State<AppBarCart> {
  int count = 0;

  _AppBarCartState();

  add() {
    setState(() {
      count += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (count > 0) {
      return IconButton(
          icon: Container(
              child: Stack(alignment: AlignmentDirectional.topEnd, children: [
            Icon(Icons.shopping_cart),
            Container(
              alignment: AlignmentDirectional.center,
              height: 12.0,
              width: 12.0,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                count.toString(),
                style: TextStyle(fontSize: 10.0),
              ),
            )
          ])),
          onPressed: widget.onPressed);
    } else {
      return Container();
    }
  }
}
