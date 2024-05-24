import 'package:flutter/material.dart';
import 'package:flutter_app/models/building.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BuildingEntryView extends StatefulWidget {
  final Building building;

  const BuildingEntryView({super.key, required this.building});

  @override
  State<BuildingEntryView> createState() => _BuildingEntryViewState();
}

class _BuildingEntryViewState extends State<BuildingEntryView> {
  String abbr = 'abbr';
  String name = 'building';
  double lat = 0.0;
  double lng = 0.0;
  int rating = 1;
  int ratings = 0;

  @override
  void initState() {
    super.initState();
    abbr = widget.building.abbr;
    name = widget.building.name;
    lat = widget.building.lat;
    lng = widget.building.lng;
    rating = widget.building.rating;
    ratings = widget.building.ratings;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme:
              const IconThemeData(color: Color.fromARGB(230, 255, 255, 255)),
          title: Semantics(
            label: abbr,
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: false,
        body: PopScope(
            canPop: false,
            onPopInvoked: (didPop) {
              return didPop ? {} : _popBack(context);
            },
              child:Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 168, 168, 168),
                      borderRadius: BorderRadius.circular(20)),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Semantics(
                            label: 'Rating',
                            child: const Text(
                              'Rating: ',
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          Semantics(
                            label: '$rating stars',
                            child: RatingBar(
                              initialRating: rating.toDouble(),
                              minRating: 1,
                              maxRating: 5,
                              allowHalfRating: false,
                              itemSize: 30,
                              ratingWidget: RatingWidget(
                                  full: const Icon(Icons.star),
                                  half: const Icon(Icons.star_half),
                                  empty: const Icon(Icons.star_border)),
                              onRatingUpdate: (newRating) {
                                rating = newRating.toInt(); 
                              },
                            ),
                          )
                        ],
                      ),
                      Semantics(
                        label: '$ratings ratings',
                        child: Text(
                          'Ratings: $ratings',
                          style: const TextStyle(fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
  }

  // pops out of view with new rating and an extra rating.
  _popBack(BuildContext context) {
    /** rating should probably be a double */
    final newRating = (ratings*widget.building.rating + rating) ~/ (ratings+1);
    final newRatings = ratings + 1;

    Building updatedBuilding = Building.withUpdatedRatings(
        building: widget.building,
        abbr: widget.building.abbr,
        name: widget.building.name,
        rating: newRating,
        ratings: newRatings,
        lat: widget.building.lat,
        lng: widget.building.lng);

    Navigator.pop(context, updatedBuilding);
  }
}
