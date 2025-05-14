import 'package:demo/first.dart';
import 'package:demo/second.dart';
import 'package:demo/third.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

ValueNotifier<List<String>> routes = ValueNotifier(['/']);

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final routerDelegate = MyRouterDelegate();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: routerDelegate,
    );
  }
}

class MyRouteInformationParser extends RouteInformationParser<String> {
  @override
  Future<String> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    return routeInformation.uri.toString();
  }

  @override
  RouteInformation? restoreRouteInformation(String configuration) {
    if (configuration.isNotEmpty) {
      return RouteInformation(uri: Uri.parse(configuration));
    }
    return null;
  }
}

class MyRouterDelegate extends RouterDelegate<String> {
  List<Page<dynamic>> createPages() {
    List<Page<dynamic>> pages = [];
    final navigationStack = routes.value;
    for (int index = 0; index < navigationStack.length; index++) {
      final route = navigationStack[index];

      switch (route) {
        case '/':
          pages.add(
            MaterialPage(
                name: 'first',
                key: const ValueKey('first'),
                child: FirstPage()),
          );
        case '/second':
          pages.add(
            MaterialPage(
                name: 'second',
                key: const ValueKey('second'),
                child: SecondPage()),
          );

        case '/third':
          pages.add(
            MaterialPage(
                name: 'third',
                key: const ValueKey('third'),
                child: ThirdPage()),
          );
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
        routes.value = routes.value.sublist(0, routes.value.length - 1);
      },
    );
  }

  @override
  Future<bool> popRoute() async {
    if (routes.value.length > 1) {
      routes.value = routes.value.sublist(0, routes.value.length - 1);
      return true;
    }
    return false;
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
