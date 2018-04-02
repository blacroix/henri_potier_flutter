import 'dart:async';
import 'dart:convert';

import 'package:henri_potier_flutter/book.dart';
import 'package:henri_potier_flutter/offer.dart';
import 'package:http/http.dart';

class CartPresenter {
  int calculateTotalPrice(List<Book> books) {
    var price = 0;
    for (final book in books) {
      price += book.price;
    }
    return price;
  }

  Future<List<Offer>> fetchOffers(books) async {
    final isbns = books.map((Book b) => b.isbn).join(',');
    final response =
        await get('http://henri-potier.xebia.fr/books/$isbns/commercialOffers');
    final json = JSON.decode(response.body);
    final offers = List<Offer>();
    for (final jsonOffer in json['offers']) {
      offers.add(Offer.fromJson(jsonOffer));
    }
    return offers;
  }

  Future<Offer> fetchBestOffer(books) async {
    final List<Offer> offers = await fetchOffers(books);
    final price = calculateTotalPrice(books);
    return getBestOffer(offers, price);
  }

  Offer getBestOffer(List<Offer> offers, int price) {
    double maxRebate = -1.0;
    Offer bestOffer;
    for (final offer in offers) {
      var rebate = calculateRebate(price, offer);
      if (rebate > maxRebate) {
        maxRebate = rebate;
        bestOffer = offer;
      }
    }
    return bestOffer;
  }

  double calculateRebate(int price, Offer offer) {
    switch (offer.type) {
      case OfferType.minus:
        return offer.value.toDouble();
      case OfferType.percentage:
        return price * offer.value / 100;
      case OfferType.slice:
        var slice = price ~/ offer.sliceValue;
        if (slice > 0) {
          return (slice * offer.value).toDouble();
        }
        return 0.0;
    }
    return 0.0;
  }

  int calculateNewPrice(int price, Offer offer) =>
      price - calculateRebate(price, offer).floor();
}
