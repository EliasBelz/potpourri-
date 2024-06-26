import 'package:flutter/material.dart';
import 'package:flutter_app/models/buildings_db.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_app/providers/campus_provider.dart';
import 'package:flutter_app/providers/weather_provider.dart';
import 'package:flutter_app/views/potpourri_app.dart';
import 'package:provider/provider.dart';

import 'providers/position_provider.dart';

/// Loads the building data from the given path
Future<BuildingsDB> loadVenuesDB(String dataPath) async {
  return BuildingsDB.initializeFromJson(await rootBundle.loadString(dataPath));
}

/// Main function that runs the app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final buildings = await loadVenuesDB('lib/data/building_data.json');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => PositionProvider()),
      ChangeNotifierProvider(
          create: (context) => CampusProvider(buildings: buildings.all)),
      ChangeNotifierProvider(create: (context) => WeatherProvider())
    ],
    child: const PotpourriApp(),
  ));
}
