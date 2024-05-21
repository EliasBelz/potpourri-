import 'package:flutter/material.dart';
import 'package:flutter_app/views/building_card.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class PotpourriApp extends StatefulWidget {
  const PotpourriApp({super.key});

  @override
  State<PotpourriApp> createState() => _PotpourriAppState();
}

class _PotpourriAppState extends State<PotpourriApp> {
  @override
  initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            backgroundColor: Color.fromARGB(255, 19, 0, 46),
            appBar: AppBar(
              title: const Text('Potpourri 🚽'),
              actions: [
                IconButton(
                    onPressed: () => {print("pin icon")},
                    icon: const Icon(Icons.pin_drop)),
              ],
            ),
            body: _mapPlaceHolder(),
            drawer: Drawer(
              child: _fillDrawer(),
            ),
          ),
        ));
  }
}

/// Fills the drawer with the list of locations
Widget _fillDrawer() {
  var items = [];

  for (int i = 0; i < 10; i++) {
    items.add(BuildingCard(
        name: 'Billy G. Center $i',
        callBack: () => {print('Billy G. Center $i')}));
  }

  return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return items[index];
      });
}

/// Placeholder widget for the map in the main view
Widget _mapPlaceHolder() {
  return Center(
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 5.0)),
          child: SizedBox(width: 400, height: 600, child: Placeholder())));
}

Widget _createMap() {
  return FlutterMap(
    options: MapOptions(
      initialCenter: LatLng(2315.0936, 1780.7913),  // gates center :^)
      initialZoom: 9.2,
    ),
    children: [
      TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'com.example.app',
      ),
      RichAttributionWidget(
        attributions: [
          TextSourceAttribution(
            'OpenStreetMap contributors',
            // onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
          ),
        ]
      )
    ]
  );
}
