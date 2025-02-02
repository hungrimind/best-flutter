import 'package:demo/auth/login_view.dart';
import 'package:demo/auth/user.dart';
import 'package:demo/auth/user_service.dart';
import 'package:demo/core/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeSuccessUserService extends Fake implements UserService {
  @override
  User createSession(String name) {
    return User(id: 1, name: name, uid: 'test-uid');
  }

  @override
  ValueNotifier<User?> get userNotifier => ValueNotifier(null);
}

class FakeFailureUserService extends Fake implements UserService {
  @override
  User createSession(String name) {
    throw Exception('Failed to create session');
  }

  @override
  ValueNotifier<User?> get userNotifier => ValueNotifier(null);
}

void main() {
  tearDown(() {
    locator.reset();
  });

  group('LoginView', () {
    testWidgets('Creates session and shows success by clearing text field',
        (tester) async {
      // Register success implementation
      locator.registerSingleton<UserService>(FakeSuccessUserService());

      await tester.pumpWidget(MaterialApp(
        home: LoginView(),
      ));

      await tester.enterText(find.byType(TextFormField), 'Test User');
      await tester.tap(find.text('Login'));
      await tester.pump();

      // Verify text field is cleared (success case)
      expect(find.text('Test User'), findsNothing);
    });

    testWidgets('Shows error message when session creation fails',
        (tester) async {
      // Register failure implementation
      locator.registerSingleton<UserService>(FakeFailureUserService());

      await tester.pumpWidget(MaterialApp(
        home: LoginView(),
      ));

      await tester.enterText(find.byType(TextFormField), 'Test User');
      await tester.tap(find.text('Login'));
      await tester.pump();

      expect(
          find.text('No user associated with this name'), findsOneWidget);
    });

    testWidgets('Shows error when trying to login with empty name',
        (tester) async {
      locator.registerSingleton<UserService>(FakeSuccessUserService());

      await tester.pumpWidget(MaterialApp(
        home: LoginView(),
      ));

      await tester.tap(find.text('Login'));
      await tester.pump();

      expect(find.text('Please enter a name'), findsOneWidget);
    });
  });
} 