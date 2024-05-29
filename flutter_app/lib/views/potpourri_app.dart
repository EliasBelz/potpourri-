import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  double? initialLat;
  double? initialLng;
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
            backgroundColor: const Color.fromARGB(255, 198, 202, 255),
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Potpourri 🚽'),
              actions: [
                Consumer<CampusProvider>(
                    builder: (context, campusProvider, child) {
                  return IconButton(
                      onPressed: () =>
                          {_imFeelingLucky(context, campusProvider)},
                      icon: const Icon(Icons.find_replace_outlined));
                }),
                Consumer<PositionProvider>(
                    builder: (context, positionProvider, child) {
                  return IconButton(
                      onPressed: () => {_centerMap(positionProvider)},
                      icon: const Icon(Icons.location_on));
                })
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
              } else {
                return Expanded(child: _createMap(positionProvider, context));
              }
            }),
          ),
        ));
  }

  _centerMap(PositionProvider positionProvider) {
    if (positionProvider.latitude != null &&
        positionProvider.longitude != null) {
      myMapController.move(
          LatLng(positionProvider.latitude!, positionProvider.longitude!), 17);
    }
  }

  // creates flutter map widget to display location
  Widget _createMap(PositionProvider positionProvider, context) {
    //47.65334425420228, -122.30558811163986 = allen center true latlong
    if (initialLat == null || initialLng == null) {
      initialLat = positionProvider.latitude;
      initialLng = positionProvider.longitude;
    }
    return Center(
      child: FlutterMap(
          mapController: myMapController,
          options: MapOptions(
            initialCenter: LatLng(initialLat!,
                initialLng!), // replace with location from provider
            initialZoom: 16,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'dev.potpourri.example',
            ),
            MarkerLayer(
              markers: [
                Marker(
                    point: LatLng(positionProvider.latitude!,
                        positionProvider.longitude!),
                    width: 80,
                    height: 80,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 5, color: Color.fromARGB(255, 255, 200, 0))
                      ), 
                      child: const Icon(
                        Icons.person_pin_circle_rounded,
                        color: Color.fromARGB(255, 245, 199, 31),
                        size: 70
                    ))),
                ..._addMapPins(context)
            ],
            )
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

// add building pins to map
_addMapPins(BuildContext context) {
  final buildings =
      Provider.of<CampusProvider>(context, listen: false).buildings;
  final out = [];
  for (final building in buildings) {
    Color color = Color.fromARGB(255, 148, 185, 255);
    out.add(Marker(
      point: LatLng(building.lat, building.lng),
      width: 60,
      height: 60,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10), // Add rounding
          border: Border.all(color: Colors.black, width: 2), // Add border
        ),
        child: Material(
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,
          child: Container(width: 60, height: 60, child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: InkWell(
              splashColor: Color.fromARGB(255, 245, 199, 31),
              onTap: () {
                Future.delayed(Duration(milliseconds: 300), () {
                  _navigateToEntry(context, building);
                });
              },
              child: const Center(
                child: Text(
                  '🚽',
                  style: TextStyle(
                    fontSize: 32.0, // Set font size
                  ),
                ),
              ),
            ),
          )),
        ),
      ),
    ));
  }

  return out;
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
            callBack: () => {
              Future.delayed(Duration(milliseconds: 300), () {
                _navigateToEntry(context, buildings[index]);
              })
            },
            subtitle: buildings[index].abbr,
            rating: buildings[index].rating,
          );
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
