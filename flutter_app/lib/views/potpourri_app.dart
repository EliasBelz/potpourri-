import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/models/building.dart';
import 'package:flutter_app/providers/campus_provider.dart';
import 'package:flutter_app/providers/position_provider.dart';
import 'package:flutter_app/views/building_card.dart';
import 'package:flutter_app/views/building_entry_view.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

/// Main application widget
class PotpourriApp extends StatefulWidget {
  const PotpourriApp({super.key});

  /// Initializes the state of the PotpourriApp
  @override
  State<PotpourriApp> createState() => _PotpourriAppState();
}

/// Companion state class for PotpourriApp
class _PotpourriAppState extends State<PotpourriApp> {
  late final MapController myMapController;

  /// Initializes the state of the PotpourriApp
  @override
  initState() {
    myMapController = MapController();
    super.initState();
  }

  /// Disposes the state of the PotpourriApp
  @override
  dispose() {
    myMapController.dispose();
    super.dispose();
  }

  /// Builds the widget
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text('Potpourri 🚽'),
              actions: [
                Consumer<CampusProvider>(
                    builder: (context, campusProvider, child) {
                  return IconButton(
                      onPressed: () =>
                          {_imFeelingLucky(context, campusProvider)},
                      icon: const Icon(Icons.find_replace_outlined));
                }),
              ],
            ),
            drawer: Drawer(
              child: _fillDrawer(),
            ),
            body: Consumer<PositionProvider>(
                builder: (context, positionProvider, child) {
              if (positionProvider.latitude == null ||
                  positionProvider.longitude == null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40.0,
                      width: 40.0,
                      child: Semantics(
                        label: 'Loading',
                        child: const CircularProgressIndicator(),
                      ),
                    ),
                    const Text(
                        'Cannot find location data. Please make sure location services are enabled! \n Or try again later ;)',
                        semanticsLabel:
                            'Cannot find location data. Please make sure location services are enabled and try again later.',
                        style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ],
                );
              }
              return Column(
                children: [
                  Center(
                    child: Text(
                        'Latitude: ${positionProvider.latitude!.toStringAsFixed(4)} Longitude: ${positionProvider.longitude!.toStringAsFixed(4)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                  ),
                  Expanded(child: _createMap()),
                ],
              );
            }),
          ),
        ));
  }

  // creates flutter map widget to display location
  Widget _createMap() {
    //47.65334425420228, -122.30558811163986 = allen center true latlong
    return Center(
      child: FlutterMap(
          mapController: myMapController,
          options: const MapOptions(
            initialCenter: LatLng(47.65334425420228,
                -122.30558811163986), // replace with location from provider
            initialZoom: 16,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'dev.potpourri.example',
            ),
          ]),
    );
  }
}

/// Navigates user to a random building.
_imFeelingLucky(BuildContext context, CampusProvider campusProvider) {
  final buildings = campusProvider.buildings;
  final randIndex = Random().nextInt(buildings.length);
  final randBuilding = buildings[randIndex];
  _navigateToEntry(context, randBuilding);
}

/// Fills the drawer with the list of locations
Widget _fillDrawer() {
  return Consumer<CampusProvider>(builder: (context, campusProvider, child) {
    List<Building> buildings = campusProvider.buildings;
    return ListView.builder(
        itemCount: buildings.length,
        itemBuilder: (context, index) {
          return BuildingCard(
              name: buildings[index].name,
              callBack: () => {_navigateToEntry(context, buildings[index])},
              subtitle: buildings[index].abbr,
              rating: buildings[index].rating,);
        });
  });
}

/// navigates user to the selected builing
Future<void> _navigateToEntry(BuildContext context, Building building) async {
  final newEntry = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BuildingEntryView(building: building)));

  if (!context.mounted) {
    return;
  }

  final campusProvider = Provider.of<CampusProvider>(context, listen: false);
  campusProvider.upsertBuilding(newEntry);
}

/// Placeholder widget for the map in the main view
Widget _mapPlaceHolder() {
  return Center(
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 5.0)),
          child:
              const SizedBox(width: 400, height: 600, child: Placeholder())));
}

// add building pins to map
_addMapPins() {
  // read buildings from file
  // for each:
  // pull out latlong for location of map pin and pass to createmappin
  // return TileLayer (?) holding all pins
}

_createMapPin(lat, long) {
  return Marker(child: Icon(Icons.pin), point: LatLng(lat, long));
  // ontap: open building details view / reviews
}
