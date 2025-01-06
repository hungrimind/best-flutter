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
}
