import 'package:flutter/foundation.dart';

class CounterNotifier extends ChangeNotifier {
  int _count = 0;
  
  int get count => _count;

  void increment() {
    _count += 2;
    notifyListeners();
  }
}