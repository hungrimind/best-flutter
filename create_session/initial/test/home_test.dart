import 'package:demo/auth/user.dart';
import 'package:demo/auth/user_service.dart';
import 'package:demo/core/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeUserService extends Fake implements UserService {
  final _userNotifier = ValueNotifier<User?>(
    User(id: 1, name: 'Test User', uid: 'test-uid'),
  );
  bool deleteSessionCalled = false;

  @override
  ValueNotifier<User?> get userNotifier => _userNotifier;

  @override
  void deleteSession() {
    deleteSessionCalled = true;
    _userNotifier.value = null;
  }
}

void main() {
  tearDown(() {
    locator.reset();
  });

  group('HomeView', () {
    // testWidgets('Shows snackbar and calls deleteSession when logging out', (tester) async {
    //   // Register fake implementation
    //   final fakeUserService = FakeUserService();
    //   locator.registerSingleton<UserService>(fakeUserService);

    //   await tester.pumpWidget(MaterialApp(
    //     home: HomeView(),
    //   ));

    //   // Verify initial state shows user name
    //   expect(find.text('Welcome Test User'), findsOneWidget);

    //   // Tap logout button
    //   await tester.tap(find.text('Logout'));
    //   await tester.pump();

    //   // Verify snackbar is shown
    //   expect(find.text('Logged out'), findsOneWidget);
      
    //   // Verify deleteSession was called
    //   expect(fakeUserService.deleteSessionCalled, true);
    // });
  });
} 