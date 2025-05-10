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
  final routeInformationParser = MyRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: routerDelegate,
      routeInformationParser: routeInformationParser,
      backButtonDispatcher: RootBackButtonDispatcher(),
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
            MaterialPage(name: 'first', key: UniqueKey(), child: FirstPage()),
          );
        case '/second':
          pages.add(
            MaterialPage(name: 'second', key: UniqueKey(), child: SecondPage()),
          );

        case '/third':
          pages.add(
            MaterialPage(name: 'third', key: UniqueKey(), child: ThirdPage()),
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
      onPopPage: (route, result) {
        print('onPopPage: ${route}');
        if (route.didPop(result)) {
          routes.value = routes.value.sublist(0, routes.value.length - 1);
          return true;
        }
        return false;
      },
    );
  }

  @override
  Future<bool> popRoute() async {
    print('popRoute');
    if (routes.value.length > 1) {
      routes.value = routes.value.sublist(0, routes.value.length - 1);
      return true;
    }
    return false;
  }

  @override
  Future<void> setNewRoutePath(String configuration) async {
    if (configuration.isEmpty) {
      routes.value = ['/'];
    } else {
      final uri = Uri.parse(configuration);
      final path = uri.path;
      if (path == '/') {
        routes.value = ['/'];
      } else if (path == '/second') {
        routes.value = ['/', '/second'];
      } else if (path == '/third') {
        routes.value = ['/', '/second', '/third'];
      }
    }
    return null;
  }

  @override
  String? get currentConfiguration {
    if (routes.value.isEmpty) {
      return null;
    }
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
