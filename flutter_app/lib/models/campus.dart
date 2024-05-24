
import 'package:flutter_app/models/building.dart';

class Campus {
  List<Building> _buildings;

  Campus({required List<Building> buildings}) : _buildings = buildings;

  List<Building> get entries {
    return List.from(_buildings);
  }

  // void upsertEntry(Building building) async {
  //   int hasEntry = _buildings.indexWhere((element) => element.uuid == building.uuid);

  //   if (hasEntry >= 0) {
  //     _buildings
  //       ..removeAt(hasEntry)
  //       ..insert(hasEntry, building);
  //   } else {
  //     _buildings.insert(0, building);
  //   }
  // }

  Campus clone() {
    return Campus(buildings: _buildings);
  }
}