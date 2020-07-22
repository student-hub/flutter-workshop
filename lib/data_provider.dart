import 'package:flutter/foundation.dart';
import 'package:preferences/preference_service.dart';

class DataProvider with ChangeNotifier {
  Map<String, double> _dataMap;

  DataProvider() {
    var keys = PrefService.get('data_map_keys');
    var values = PrefService.get('data_map_values');

    _dataMap = Map<String, double>.from(keys.asMap().map(
        (index, key) => MapEntry(key, double.tryParse(values[index] ?? 0))));
  }

  Map<String, double> get dataMap => _dataMap;

  set dataMap(Map<String, double> newDataMap) {
    _dataMap = newDataMap;

    PrefService.setStringList(
        'data_map_keys', List<String>.from(_dataMap.keys));
    PrefService.setStringList('data_map_values',
        List<String>.from(_dataMap.values.map((value) => value.toString())));

    notifyListeners();
  }
}
