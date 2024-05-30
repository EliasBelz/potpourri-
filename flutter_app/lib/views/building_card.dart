import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

/// A card that displays information about a building
class BuildingCard extends StatelessWidget {
  /// Building name
  final String name;

  /// Callback function
  final VoidCallback callBack;

  /// Card subtitle
  final String subtitle;

  /// Building rating
  final double rating;

  /// Constructor
  /// Parameters:
  /// name (String): The name of the building
  /// callBack (VoidCallback): The function to be called when the card is tapped
  /// subtitle (String): The subtitle of the card
  /// rating (double): The rating of the building
  const BuildingCard(
      {required this.name,
      required this.callBack,
      required this.subtitle,
      required this.rating,
      super.key});

  /// Builds the widget
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
