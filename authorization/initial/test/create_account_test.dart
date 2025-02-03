import 'package:demo/auth/create_account_view.dart';
import 'package:demo/auth/user.dart';
import 'package:demo/auth/user_service.dart';
import 'package:demo/core/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Create two fake implementations for success and failure scenarios
class FakeSuccessUserService extends Fake implements UserService {
  @override
  User createUser(User user) {
    return User(id: 1, name: user.name, uid: user.uid);
  }
}

class FakeFailureUserService extends Fake implements UserService {
  @override
  User createUser(User user) {
    throw Exception('Failed to create user');
  }
}

void main() {
  tearDown(() {
    locator.reset();
  });

  group('CreateAccountPage', () {
    testWidgets('Creates user and shows success message', (tester) async {
      // Register success implementation
      locator.registerSingleton<UserService>(FakeSuccessUserService());

      await tester.pumpWidget(MaterialApp(
        home: CreateAccountView(),
      ));

      await tester.enterText(find.byType(TextFormField), 'Test User');
      await tester.tap(find.text('Create Account'));
      await tester.pump();

      expect(
        find.text(
            'User created, click database viewer in top right to see users'),
        findsOneWidget,
      );
    });

    testWidgets('Shows error message when user creation fails', (tester) async {
      // Register failure implementation
      locator.registerSingleton<UserService>(FakeFailureUserService());

      await tester.pumpWidget(MaterialApp(
        home: CreateAccountView(),
      ));

      await tester.enterText(find.byType(TextFormField), 'Test User');
      await tester.tap(find.text('Create Account'));
      await tester.pump();

      expect(find.text('User not created'), findsOneWidget);
    });
  });
}
