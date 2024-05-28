import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BuildingCard extends StatelessWidget {
  final String name;
  final VoidCallback callBack;
  final String subtitle;
  final double rating;
  const BuildingCard(
      {required this.name,
      required this.callBack,
      required this.subtitle,
      required this.rating,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
            splashColor: Colors.amber,
            onTap: callBack,
            child: ListTile(
              leading: const Icon(Icons.house_outlined),
              title: Text(name),
              subtitle: Row(children: [
                Expanded(child: Text(subtitle)),
                Expanded(
                  child: RatingBar(
                    ignoreGestures: true,
                    initialRating: rating,
                    minRating: 0.5,
                    maxRating: 5,
                    allowHalfRating: true,
                    itemSize: 20,
                    ratingWidget: RatingWidget(
                        full: const Icon(Icons.star),
                        half: const Icon(Icons.star_half),
                        empty: const Icon(Icons.star_border)),
                    onRatingUpdate: (newRating) {},
                  ),
                ),
              ]),
            )));
  }
}
