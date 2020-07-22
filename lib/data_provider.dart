import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DataProvider with ChangeNotifier {
  Map<String, double> _dataMap;
  final Firestore _db = Firestore.instance;

  Map<String, double> get dataMap => _dataMap;

  set dataMap(Map<String, double> newDataMap) {
    _dataMap = newDataMap;
    updateDataMap(newDataMap);
    notifyListeners();
  }

  Future<Map<String, double>> fetchDataMap() async {
    DocumentSnapshot snap =
        await _db.collection('data').document('vztH0rlKnqYCOyzK11HS').get();

    _dataMap = Map<String, double>.from(snap.data['data_map']
        .map((key, value) => MapEntry(key, value.toDouble())));

    return _dataMap;
  }

  void updateDataMap(Map<String, double> newDataMap) async {
    DocumentReference ref =
        _db.collection('data').document('vztH0rlKnqYCOyzK11HS');

    await ref.updateData({'data_map': newDataMap});
  }
}
