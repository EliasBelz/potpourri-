import 'package:flutter/material.dart';
import 'package:flutter_app/views/potpourri_app.dart';
import 'package:provider/provider.dart';

import 'providers/position_provider.dart';

void main() {
  // TODO inti db here
  // TODO init change notifier providers here
  runApp(ChangeNotifierProvider(
    create: (context) => PositionProvider(),
    child: PotpourriApp(),
  ));
}
