import 'package:flutter/material.dart';

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
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
              backgroundColor: Color.fromARGB(255, 181, 141, 240),
              body: Placeholder()),
        ));
  }
}
