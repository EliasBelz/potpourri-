import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/weather_checker.dart';
import 'package:flutter_app/models/building.dart';
import 'package:flutter_app/providers/campus_provider.dart';
import 'package:flutter_app/providers/position_provider.dart';
import 'package:flutter_app/providers/weather_provider.dart';
import 'package:flutter_app/views/building_card.dart';
import 'package:flutter_app/views/building_entry_view.dart';
import 'package:flutter_app/models/weather_conditions.dart';
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
  // Initial Latitude for centering the map
  double? initialLat;
  // Initial Longitude for centering the map
  double? initialLng;
  // Map controller for the flutter map
  late final MapController myMapController;

  late final WeatherChecker _weatherChecker;
  late final Timer _checkerTimer;

  /// Initializes the state of the PotpourriApp
  @override
  initState() {
    myMapController = MapController();
    final singleUseWeatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);
    _weatherChecker = WeatherChecker(singleUseWeatherProvider);
    _checkerTimer = Timer.periodic(
        const Duration(
          seconds: 1,
        ),
        (timer) => _weatherChecker.fetchAndUpdateCurrentSeattleWeather());
    super.initState();
  }

  /// Disposes the state of the PotpourriApp
  @override
  dispose() {
    myMapController.dispose();
    _checkerTimer.cancel();
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
              centerTitle: true,
              title: const Text(
                'Potpourri 🚽',
                semanticsLabel: "Potpourri",
              ),
              actions: [
                Consumer<CampusProvider>(
                    builder: (context, campusProvider, child) {
                  return Semantics(
                      label: "Open a random building's page",
                      child: IconButton(
                          onPressed: () =>
                              {_imFeelingLucky(context, campusProvider)},
                          icon: const IconTheme(
                              data: IconThemeData(size: 40),
                              child: Icon(Icons.find_replace_outlined))));
                }),
                Consumer<PositionProvider>(
                    builder: (context, positionProvider, child) {
                  return Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Semantics(
                          label: 'Recenter map',
                          child: IconButton(
                              onPressed: () => {_centerMap(positionProvider)},
                              icon: const IconTheme(
                                  data: IconThemeData(size: 40),
                                  child: Icon(Icons.location_on)))));
                })
              ],
            ),
            drawer: Drawer(
              semanticLabel: "Building list",
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
                _weatherChecker.updateLocation(
                    latitude: positionProvider.latitude!,
                    longitude: positionProvider.longitude!);
                return Column(
                  children: [
                    Consumer<WeatherProvider>(
                        builder: (context, weatherProvider, child) {
                      final condition = weatherProvider.formattedCondition;

                      return condition == WeatherCondition.unknown
                          ? const Text(
                              'Failed to get weather :(',
                              semanticsLabel: "Failed to get weather",
                            )
                          : Text(
                              'Currently ${weatherProvider.tempInFarenheit} °F and ${weatherProvider.formattedCondition} ${weatherProvider.conditionEmoji}',
                              semanticsLabel:
                                  "Currently ${weatherProvider.tempInFarenheit} °F and ${weatherProvider.formattedCondition} ${weatherProvider.conditionEmoji}",
                            );
                    }),
                    Expanded(child: _createMap(positionProvider, context)),
                  ],
                );
              }
            }),
          ),
        ));
  }

  /// Centers the map on the user's location
  _centerMap(PositionProvider positionProvider) {
    if (positionProvider.latitude != null &&
        positionProvider.longitude != null) {
      myMapController.move(
          LatLng(positionProvider.latitude!, positionProvider.longitude!), 17);
    }
  }

  /// creates flutter map widget to display location
  Widget _createMap(PositionProvider positionProvider, context) {
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
                            border: Border.all(
                                width: 5,
                                color: const Color.fromARGB(255, 255, 200, 0))),
                        child: const Icon(Icons.person_pin_circle_rounded,
                            color: Color.fromARGB(255, 245, 199, 31),
                            shadows: <Shadow>[Shadow(color: Colors.black, blurRadius: 10)],
                            size: 70))),
                ..._addMapPins(context)
              ],
            )
          ]),
    );
  }
}

/// Navigates user to a random building.
/// parameters:
///  context: the current context
/// campusProvider: the campus provider
_imFeelingLucky(BuildContext context, CampusProvider campusProvider) {
  final buildings = campusProvider.buildings;
  final randIndex = Random().nextInt(buildings.length);
  final randBuilding = buildings[randIndex];
  _navigateToEntry(context, randBuilding);
}

/// add building pins to map
/// parameters:
/// context: the current build context
_addMapPins(BuildContext context) {
  final buildings =
      Provider.of<CampusProvider>(context, listen: false).buildings;
  final out = [];
  for (final building in buildings) {
    Color color = const Color.fromARGB(255, 148, 185, 255);
    out.add(Marker(
      point: LatLng(building.lat, building.lng),
      width: 50,
      height: 50,
      child: Semantics(
        label: building.name,
        hint: "Press to open the review page and give a rating",
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: InkWell(
                splashColor: const Color.fromARGB(255, 245, 199, 31),
                onTap: () {
                  Future.delayed(const Duration(milliseconds: 300), () {
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
            ),
          ),
        ),
      ),
    ));
  }

  return out;
}

/// Creates list view of buildings sorted by rating in descending order
Widget _fillDrawer() {
  return Consumer<CampusProvider>(builder: (context, campusProvider, child) {
    List<Building> buildings = campusProvider.buildings;
    buildings.sort((a, b) => b.rating.compareTo(a.rating));
    return ListView.builder(
        itemCount: buildings.length,
        itemBuilder: (context, index) {
          return BuildingCard(
            name: buildings[index].name,
            callBack: () => {
              Future.delayed(const Duration(milliseconds: 300), () {
                _navigateToEntry(context, buildings[index]);
              })
            },
            subtitle: buildings[index].abbr,
            rating: buildings[index].rating,
          );
        });
  });
}

/// navigates user to the selected building
/// parameters:
/// context: the current build context
/// building: the selected building
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
