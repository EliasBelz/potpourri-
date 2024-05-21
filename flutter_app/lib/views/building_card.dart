import 'package:flutter/material.dart';

class BuildingCard extends StatelessWidget {
  final String name;
  final VoidCallback callBack;
  const BuildingCard({required this.name, required this.callBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
            splashColor: Colors.amber,
            onTap: callBack,
            child: ListTile(
              leading: Icon(Icons.house_outlined),
              title: Text(name),
              subtitle: Text('Its aight'),
            )));
  }
}
