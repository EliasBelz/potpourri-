import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class PositionProvider extends ChangeNotifier {
  /// Current latitude
  double? latitude;

  /// Current longitude
  double? longitude;
  // Timer to update the position
  late Timer _updateTimer;

  /// Constructor Initializes the timer to update the position every second
  PositionProvider() {
    _updateTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      await updatePosition();
    });
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<void> updatePosition() async {
    // Update weather if its available if not set lat/lon to null signifying
    // that we don't have a location
    try {
      final position = await _determinePosition();
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (_) {
      latitude = null;
      longitude = null;
    } finally {
      notifyListeners();
    }
  }

  /// Deconstructor, disposes of the timer
  @override
  void dispose() {
    _updateTimer.cancel();
    super.dispose();
  }
}
