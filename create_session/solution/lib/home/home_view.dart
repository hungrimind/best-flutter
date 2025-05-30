import 'package:demo/auth/user_service.dart';
import 'package:demo/core/database_view.dart';
import 'package:demo/core/locator.dart';
import 'package:demo/home/home_view_model.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeViewModel homeViewModel = HomeViewModel(
    userService: locator<UserService>(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Home'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DatabasePage(),
                ),
              );
            },
            child: const Text('Show Database'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ValueListenableBuilder(
              valueListenable: homeViewModel.userNotifier,
              builder: (context, user, child) {
                return Text('Welcome ${user?.name}',
                    style: Theme.of(context).textTheme.headlineLarge);
              },
            ),
            TextButton(
              onPressed: () {
                homeViewModel.logout();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Logged out'),
                  ),
                );
              },
              child: Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}
