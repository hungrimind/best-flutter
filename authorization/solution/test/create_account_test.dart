import 'package:demo/auth/create_account_view.dart';
import 'package:demo/auth/user.dart';
import 'package:demo/auth/user_service.dart';
import 'package:demo/core/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Create two fake implementations for success and failure scenarios
class FakeSuccessUserService extends Fake implements UserService {
  User? lastCreatedUser;

  @override
  User createUser(User user) {
    lastCreatedUser = user;
    return User(id: 1, name: user.name, uid: user.uid, isAdmin: user.isAdmin);
  }
}

class FakeFailureUserService extends Fake implements UserService {
  @override
  User createUser(User user) {
    throw Exception('Failed to create user');
  }
}

void main() {
  late FakeSuccessUserService fakeUserService;

  setUp(() {
    fakeUserService = FakeSuccessUserService();
    locator.registerSingleton<UserService>(fakeUserService);
  });

  tearDown(() {
    locator.reset();
  });

  group('CreateAccountPage Messages and User Creation', () {
    testWidgets('Creates regular user with correct isAdmin value',
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: CreateAccountView(),
      ));

      await tester.enterText(find.byType(TextFormField), 'regular_user');
      await tester.tap(find.text('Create Account'));
      await tester.pump();

      expect(
        find.text(
            'User created, click database viewer in top right to see users'),
        findsOneWidget,
      );
      expect(fakeUserService.lastCreatedUser?.isAdmin, equals(0));
      expect(fakeUserService.lastCreatedUser?.name, equals('regular_user'));
    });

    testWidgets('Creates admin user with correct isAdmin value',
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: CreateAccountView(),
      ));

      await tester.enterText(find.byType(TextFormField), 'admin');
      await tester.tap(find.text('Create Account'));
      await tester.pump();

      expect(
        find.text(
            'Admin user created, click database viewer in top right to see users'),
        findsOneWidget,
      );
      expect(fakeUserService.lastCreatedUser?.isAdmin, equals(1));
      expect(fakeUserService.lastCreatedUser?.name, equals('admin'));
    });
  });
}
