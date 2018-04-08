# Henri Potier with Flutter

POC of coding Henri Potier exercise with Flutter Beta.

## Demo

<img src="https://i.imgur.com/ABkJ8fx.png" width="200" /> <img src="https://i.imgur.com/LUeHIuP.png" width="200" /> <img src="https://i.imgur.com/cLGDMAG.png" width="200" />

## Live Coding

> Live Coding focus on book list retrieval and list display, it should take ~15 min.

### Steps

- [ ] Create a new Flutter project
- [ ] Remove extra comments
- [ ] Create `Book` class with `title`
- [ ] Add `_book` to `_MyHomePageState`
- [ ] Remove method `_incrementCounter`
- [ ] Add `ListView.builder`
- [ ] Use `=> Text` as `itemBuilder`
- [ ] Then use `=> ListTile`
- [ ] Override `initState`
- [ ] Add `async`, `http`, `convert`

```
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
```

- [ ] Add method `fetchBooks`

```
Future<List<Book>> fetchBooks() async {
  final response = await http.get('http://henri-potier.xebia.fr/books');
  final json = JSON.decode(response.body);
  final books = List<Book>();
  for (final jsonBook in json) {
    books.add(Book(jsonBook['title']));
  }
  return books;
}
```

- [ ] Code method `initState`

```
@override
void initState() {
  super.initState();
  fetchBooks().then((books) {
    setState(() {
      this._books = books;
    });
  });
}
```

- [ ] Live coding can stop here, or go further if more time
- [ ] Add `cover` to `Book` and convert from `JSON`
- [ ] Add `Image.network` to `ListTile`
- [ ] Add `Column` then `Divider` to `itemBuilder`

That's it folks!

