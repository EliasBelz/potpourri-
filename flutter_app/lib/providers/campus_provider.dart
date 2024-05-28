import 'package:flutter/material.dart';
import 'package:flutter_app/models/building.dart';

class CampusProvider extends ChangeNotifier {
  /// List of buildings that represent the campus
  final List<Building> _buildings;

  /// Constructor
  /// parameters:
  /// - buildings (List<Building>): List of buildings that represent the campus
  CampusProvider({required List<Building> buildings}) : _buildings = buildings;

  /// Getter for the list of buildings
  /// returns a copy of the list of buildings
  List<Building> get buildings {
    return List.from(_buildings);
  }

  /// Adds or updates a building in the list of buildings
  upsertBuilding(Building newBuilding) {
    int index =
        _buildings.indexWhere((element) => element.abbr == newBuilding.abbr);
    if (index == -1) {
      _buildings.add(newBuilding);
    } else {
      _buildings[index] = newBuilding;
    }
    notifyListeners();
  }
}
