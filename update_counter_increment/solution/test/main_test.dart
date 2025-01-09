import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/main.dart';

void main() {
  testWidgets('App theme should be seeded with Colors.blue',
      (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const MyApp());

    // Find the MaterialApp widget
    final MaterialApp materialApp =
        tester.widget<MaterialApp>(find.byType(MaterialApp));

    // Get the ThemeData
    final ThemeData theme = materialApp.theme!;

    // Verify that the colorScheme is seeded with Colors.blue
    expect(theme.colorScheme, isA<ColorScheme>(),
        reason: 'The colorScheme should be a ColorScheme');
    expect(theme.colorScheme.primary,
        equals(ColorScheme.fromSeed(seedColor: Colors.blue).primary),
        reason: 'The primary color should be blue');
  });

  testWidgets('Counter should increment by 10', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const MyApp());

    // Verify that counter starts at 0
    expect(find.text('0'), findsOneWidget);
    expect(find.text('10'), findsNothing);

    // Tap the '+' icon and trigger a frame
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that counter incremented by 10
    expect(find.text('0'), findsNothing);
    expect(find.text('10'), findsOneWidget);

    // Tap again to verify it adds another 10
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that counter is now 20
    expect(find.text('20'), findsOneWidget);
  });
}
