import 'package:flutter/foundation.dart';

class DataProvider with ChangeNotifier {
  Map<String, double> _dataMap;

  DataProvider() {
    _dataMap = new Map();
    _dataMap.putIfAbsent("Flutter", () => 5);
    _dataMap.putIfAbsent("React", () => 3);
    _dataMap.putIfAbsent("Xamarin", () => 2);
    _dataMap.putIfAbsent("Ionic", () => 2);
  }

  Map<String, double> get dataMap => _dataMap;

  set dataMap(Map<String, double> newDataMap) {
    _dataMap = newDataMap;
    notifyListeners();
  }
}