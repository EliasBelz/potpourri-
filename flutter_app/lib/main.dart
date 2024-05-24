import 'package:flutter/material.dart';
import 'package:flutter_app/models/building.dart';
import 'package:flutter_app/views/building_entry_view.dart';
import 'package:flutter_app/views/potpourri_app.dart';

void main() {
  // TODO inti db here
  // TODO init change notifier providers here
  runApp(MaterialApp(home: BuildingEntryView(building: Building(abbr: 'abbr', name: 'name', lat: 0.0, lng: 0.0, rating: 1, ratings: 22))));
}
