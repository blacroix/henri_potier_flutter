import 'package:test/test.dart';
import 'package:henri_potier_flutter/cart/cart_presenter.dart';
import 'package:henri_potier_flutter/offer.dart';

void main() {
  final presenter = CartPresenter();

  group('calculate rebate', () {
    test('minus', () {
      final minus10 = Offer(OfferType.minus, 10, 0);
      final rebate = presenter.calculateRebate(100, minus10);
      expect(rebate, equals(10.0));
    });

    test('percentage', () {
      final percent50 = Offer(OfferType.percentage, 50, 0);
      final rebate = presenter.calculateRebate(100, percent50);
      expect(rebate, equals(50.0));
    });

    test('slice', () {
      final slice90 = Offer(OfferType.slice, 20, 90);
      final rebate = presenter.calculateRebate(100, slice90);
      expect(rebate, equals(20));
    });
  });

  group('calculate new price', () {
    test('minus', () {
      final minus10 = Offer(OfferType.minus, 10, 0);
      final price = presenter.calculateNewPrice(100, minus10);
      expect(price, equals(90));
    });

    test('percentage', () {
      final percent50 = Offer(OfferType.percentage, 50, 0);
      final price = presenter.calculateNewPrice(100, percent50);
      expect(price, equals(50));
    });

    test('slice', () {
      final slice50 = Offer(OfferType.slice, 20, 50);
      final price = presenter.calculateNewPrice(100, slice50);
      expect(price, equals(60));
    });
  });

  group('get best effor', () {
    test('percent50 is best offer', () {
      final minus10 = Offer(OfferType.minus, 10, 0);
      final percent50 = Offer(OfferType.percentage, 50, 0);
      final bestOffer = presenter.getBestOffer([minus10, percent50], 100);
      expect(bestOffer, equals(percent50));
    });
  });
}
