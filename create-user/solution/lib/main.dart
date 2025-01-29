import 'package:demo/home.dart';
import 'package:demo/locator.dart';
import 'package:demo/login/login_page.dart';
import 'package:demo/sqlite_abstraction.dart';
import 'package:demo/user_service.dart';
import 'package:flutter/material.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  await locator<SqliteAbstraction>().loadSqlite();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final UserService userService = locator.get<UserService>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ValueListenableBuilder(
        valueListenable: userService.userNotifier,
        builder: (context, user, child) {
          if (user == null) {
            return const LoginPage(title: 'Login');
          }
          return const HomePage();
        },
      ),
    );
  }
}
