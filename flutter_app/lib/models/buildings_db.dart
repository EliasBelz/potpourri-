import 'dart:convert';

import 'package:flutter_app/models/building.dart';

/// Represents the buildings database.
class BuildingsDB {
  late final List<Building> _buildings;

  /// Constructs a BuildingDB given json to parse into a list of buildings
  BuildingsDB.initializeFromJson(String json) {
    final buildingList = jsonDecode(json) as List;
    _buildings =
        buildingList.map((building) => Building.fromJson(building)).toList();
  }

  /// Returns a list of all buildings in the database.
  List<Building> get all => List.from(_buildings);
}
