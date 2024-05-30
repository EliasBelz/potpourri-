import 'dart:convert';
import 'package:flutter_app/models/building.dart';

/// This class represents a database of buildings on campus
class BuildingsDB {
  late final List<Building> _buildings;

  /// Constructs a database from a JSON of buildings
  /// Parameters:
  /// - json (String): JSON string of buildings
  BuildingsDB.initializeFromJson(String json) {
    final buildingList = jsonDecode(json) as List;
    _buildings =
        buildingList.map((building) => Building.fromJson(building)).toList();
  }

  /// Getter for the list of buildings. Returns a copy.
  List<Building> get all => List.from(_buildings);
}
