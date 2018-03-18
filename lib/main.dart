import 'package:flutter/material.dart';

import 'package:henri_potier_flutter/library/library_page.dart';

void main() => runApp(new HenriPotierApp());

class HenriPotierApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Henri Potier',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LibraryPage(),
    );
  }
}
