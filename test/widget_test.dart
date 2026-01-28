// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:arasaac_pictogramas/main.dart';

void main() {
  testWidgets('Navigation between search and favorites screens', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify that we start on the search screen by checking for its unique subtitle
    expect(find.text('Tus pictogramas guardados'), findsNothing);
    
    // Find and tap the favorites button
    final favoritesButton = find.widgetWithText(InkWell, 'Favoritos');
    expect(favoritesButton, findsOneWidget);
    
    await tester.tap(favoritesButton);
    await tester.pumpAndSettle();

    // Verify that we navigated to the favorites screen by checking its unique subtitle
    expect(find.text('Tus pictogramas guardados'), findsOneWidget);
    
    // Tap back to search
    final searchButton = find.widgetWithText(InkWell, 'Buscar');
    await tester.tap(searchButton);
    await tester.pumpAndSettle();
    
    // Verify we're back on search screen (favorites subtitle should not be visible)
    expect(find.text('Tus pictogramas guardados'), findsNothing);
  });
}
