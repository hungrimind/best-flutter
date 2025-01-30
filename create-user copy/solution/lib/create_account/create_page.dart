import 'package:demo/create_account/create_view_model.dart';
import 'package:demo/database_page.dart';
import 'package:demo/locator.dart';
import 'package:demo/sqlite_abstraction.dart';
import 'package:demo/user_service.dart';
import 'package:flutter/material.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  late final CreateAccountViewModel createAccountViewModel;
  late final UserService userService = locator.get<UserService>();
  late final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    createAccountViewModel = CreateAccountViewModel(userService);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Create Account'),
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
          valueListenable: userService.userNotifier,
          builder: (context, user, child) {
            return Column(
              children: [
                TextField(
                  controller: nameController,
                ),
                ElevatedButton(
                    onPressed: () {
                      createAccountViewModel.createUser(nameController.text);
                      Navigator.pop(context);
                    },
                    child: Text('Create Account')),
              ],
            );
          },
        ),
      ),
    );
  }
}
