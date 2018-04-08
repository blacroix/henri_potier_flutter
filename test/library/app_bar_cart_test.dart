import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../lib/library/app_bar_cart.dart';

void main() {
  const appBarCartIconKey = const Key('app-bar-cart-icon');
  const appBarCartKey = const Key('app-bar-cart');

  testWidgets('chip is not visible at init', (WidgetTester tester) async {
    await tester.pumpWidget(new AppBarCart(() {}));
    expect(find.byKey(appBarCartIconKey), findsNothing);
  });

  testWidgets('chip is visible after on add', (WidgetTester tester) async {
    // GIVEN
    var widget = MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
        home: Scaffold(
          body: AppBarCart(() {}),
        ),
      ),
    );
    await tester.pumpWidget(widget);
    AppBarCart appBarCart = tester.firstWidget(find.byKey(appBarCartKey));

    // WHEN
    appBarCart.add();
    await tester.pump();

    // THEN
    expect(appBarCart.state.count, 1);
    expect(find.byKey(appBarCartIconKey), findsOneWidget);
  });
}
