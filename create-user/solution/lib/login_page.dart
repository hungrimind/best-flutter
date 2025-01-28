import 'package:demo/database_page.dart';
import 'package:flutter/material.dart';

import 'login_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginViewModel loginViewModel;

  @override
  void initState() {
    super.initState();
    loginViewModel = LoginViewModel();
  }

  @override
  void dispose() {
    loginViewModel.dispose();
    super.dispose();
  }

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
                            sqliteAbstraction: loginViewModel.sqliteAbstraction,
                          )));
            },
            icon: Icon(Icons.list),
          ),
        ],
      ),
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: loginViewModel.userNotifier,
          builder: (context, user, child) {
            if (user != null) {
              return Text(
                'User: ${user.name} ${user.id} ${user.uid}',
                style: Theme.of(context).textTheme.headlineMedium,
              );
            }
            return Text(
              'No user',
              style: Theme.of(context).textTheme.headlineMedium,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          loginViewModel.createUser('Tadas');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
