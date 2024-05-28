import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(47.65334425420228,
              -122.30558811163986), // replace with location from provider
          initialZoom: 17,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'dev.potpourri.example',
          ),
        ]);
  }
}
