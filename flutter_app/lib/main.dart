import 'package:flutter/material.dart';
import 'package:flutter_app/models/buildings_db.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_app/views/potpourri_app.dart';
import 'package:flutter_app/views/building_entry_view.dart';
import 'package:provider/provider.dart';

import 'providers/position_provider.dart';

Future<BuildingsDB> loadVenuesDB(String dataPath) async {
  return BuildingsDB.initializeFromJson(await rootBundle.loadString(dataPath));
}

void main() async {
  // TODO inti db here
  // TODO init change notifier providers here
  WidgetsFlutterBinding.ensureInitialized();

  final buildings = await loadVenuesDB('lib/data/building_data.json');
  print(buildings.all.length);
  runApp(ChangeNotifierProvider(
    create: (context) => PositionProvider(),
    child: PotpourriApp(),
  ));
}
