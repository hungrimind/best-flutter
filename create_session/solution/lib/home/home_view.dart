import 'package:demo/auth/user_service.dart';
import 'package:demo/core/locator.dart';
import 'package:demo/home/home_view_model.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeViewModel homeViewModel =
      HomeViewModel(userService: locator<UserService>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ValueListenableBuilder(
              valueListenable: homeViewModel.userNotifier,
              builder: (context, user, child) {
                return Text(
                    'Welcome ${user?.name}',
                    style: Theme.of(context).textTheme.headlineLarge);
              },
            ),
            TextButton(onPressed: homeViewModel.logout, child: Text('Logout'))
          ],
        ),
      ),
    );
  }
}
