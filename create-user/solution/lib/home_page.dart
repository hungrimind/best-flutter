import 'package:demo/home_page_view_model.dart';
import 'package:demo/locator.dart';
import 'package:demo/user_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomePageViewModel homePageViewModel = HomePageViewModel(
    userService: locator<UserService>(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              homePageViewModel.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: homePageViewModel.userNotifier,
          builder: (context, user, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Welcome ${user?.name ?? ''}'),
              ],
            );
          },
        ),
      ),
    );
  }
}
