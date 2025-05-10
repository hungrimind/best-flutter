import 'package:demo/first.dart';
import 'package:demo/second.dart';
import 'package:demo/third.dart';
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
  final routerDelegate = MyRouterDelegate();
  final routeInformationParser = MyRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: routerDelegate,
      routeInformationParser: routeInformationParser,
    );
  }
}

class MyRouteInformationParser extends RouteInformationParser<String> {
  @override
  Future<String> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    final uri = routeInformation.uri;

    return uri.toString();
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
            MaterialPage(key: ValueKey('Page_$index'), child: FirstPage()),
          );
        case '/second':
          pages.add(
            MaterialPage(key: ValueKey('Page_$index'), child: SecondPage()),
          );

        case '/third':
          pages.add(
            MaterialPage(key: ValueKey('Page_$index'), child: ThirdPage()),
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
        print('onDidRemovePage: ${page.name}');
      },
    );
  }

  @override
  Future<bool> popRoute() {
    if (routes.value.length > 1) {
      navigatorKey.currentState?.pop();
      return Future.value(true);
    }
    return Future.value(false);
  }

  @override
  Future<void> setNewRoutePath(String configuration) {
    return Future.value();
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
