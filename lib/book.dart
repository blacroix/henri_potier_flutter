class Book {
  final String isbn;
  final String title;
  final int price;
  final String cover;
  final List<String> synopsis;

  Book(this.isbn, this.title, this.price, this.cover, this.synopsis);

  factory Book.fromJson(Map<String, dynamic> json) {
    final List<String> desc = [];
    for (final synopsis in json['synopsis']) {
      desc.add(synopsis);
    }
    return new Book(
        json['isbn'], json['title'], json['price'], json['cover'], desc);
  }
}
