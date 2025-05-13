import 'package:demo/first.dart';
import 'package:demo/second.dart';
import 'package:demo/third.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

ValueNotifier<List<String>> routes = ValueNotifier(['/']);

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: MyRouterDelegate(),
    );
  }
}

class MyRouterDelegate extends RouterDelegate<String> {
  List<Page<dynamic>> createPages() {
    List<Page<dynamic>> pages = [];
    for (int index = 0; index < routes.value.length; index++) {
      switch (routes.value[index]) {
        case '/':
          pages.add(
            MaterialPage(key: const ValueKey('first'), child: FirstPage()),
          );
          break;
        case '/second':
          pages.add(
            MaterialPage(key: const ValueKey('second'), child: SecondPage()),
          );
          break;
        case '/third':
          pages.add(
            MaterialPage(key: const ValueKey('third'), child: ThirdPage()),
          );
          break;
      }
    }
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: createPages(),
      onDidRemovePage: (page) {
        print('onDidRemovePage: ${routes.value}');
      },
    );
  }

  @override
  Future<bool> popRoute() async {
    if (routes.value.length > 1) {
      routes.value = routes.value.sublist(0, routes.value.length - 1);
      return SynchronousFuture(true);
    }
    return SynchronousFuture(false);
  }

  @override
  Future<void> setNewRoutePath(String configuration) async {
    routes.value = [configuration];
  }

  @override
  String? get currentConfiguration {
    return routes.value.last;
  }

  @override
  void removeListener(VoidCallback listener) {
    routes.removeListener(listener);
  }

  @override
  void addListener(VoidCallback listener) {
    routes.addListener(listener);
  }
}
