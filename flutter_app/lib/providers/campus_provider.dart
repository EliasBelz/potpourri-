import 'package:flutter/material.dart';
import 'package:flutter_app/models/building.dart';

class CampusProvider extends ChangeNotifier {
  final List<Building> _buildings;

  CampusProvider({required List<Building> buildings}) : _buildings = buildings;

  List<Building> get buildings {
    return List.from(_buildings);
  }

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
