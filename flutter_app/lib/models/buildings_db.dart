import 'dart:convert';

import 'package:flutter_app/models/building.dart';

class BuildingsDB {
  late final List<Building> _buildings;

  BuildingsDB.initializeFromJson(String json) {
    final buildingList = jsonDecode(json) as List;
    _buildings =
        buildingList.map((building) => Building.fromJson(building)).toList();
  }

  List<Building> get all => List.from(_buildings);
}
