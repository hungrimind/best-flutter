import 'package:demo/create_account/create_page.dart';
import 'package:demo/database_page.dart';
import 'package:demo/locator.dart';
import 'package:demo/sqlite_abstraction.dart';
import 'package:demo/user_service.dart';
import 'package:flutter/material.dart';

import 'login_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginViewModel loginViewModel = LoginViewModel(
    userService: locator<UserService>(),
  );

  late final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DatabasePage(
                    sqliteAbstraction: locator<SqliteAbstraction>(),
                  ),
                ),
              );
            },
            icon: Icon(Icons.list),
          ),
        ],
      ),
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: loginViewModel.userNotifier,
          builder: (context, user, child) {
            return Column(
              children: [
                TextField(
                  controller: nameController,
                ),
                ElevatedButton(
                    onPressed: () {
                      try {
                        loginViewModel.login(nameController.text);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())));
                      }
                    },
                    child: Text('Login')),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateAccountPage(),
                      ),
                    );
                  },
                  child: Text('Create Account'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
