import 'package:flutter/material.dart';
import 'package:flutter_app/models/building.dart';
import 'package:flutter_app/models/review.dart';
import 'package:flutter_app/utils/rating_helper.dart';
import 'package:flutter_app/views/review_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

/// Represents a BuildingEntryView.
class BuildingEntryView extends StatefulWidget {
  final Building building;

  /// Constructs a BuildingEntryView given a building.
  const BuildingEntryView({super.key, required this.building});

  /// Initializes the state of the BuildingEntryView.
  @override
  State<BuildingEntryView> createState() => _BuildingEntryViewState();
}

/// Companion state class for BuildingEntryView.
class _BuildingEntryViewState extends State<BuildingEntryView> {
  late String abbr;
  late String name;
  late double lat;
  late double lng;
  late double rating;
  late int ratingCount;
  late List<Review> reviews;

  /// initializes state of building entry
  @override
  void initState() {
    super.initState();
    abbr = widget.building.abbr;
    name = widget.building.name;
    lat = widget.building.lat;
    lng = widget.building.lng;
    rating = widget.building.rating;
    ratingCount = widget.building.ratingCount;
    reviews = widget.building.reviews;
  }

  /// constructs the BuildingEntryView widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Semantics(
          label: name,
          child: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Semantics(
                  label: 'Add new bathroom review',
                  child: IconButton(
                      onPressed: () => {
                            setState(() {
                              reviews.add(Review());
                              ratingCount = reviews.length;
                            })
                          },
                      icon: const IconTheme(
                          data: IconThemeData(size: 40),
                          child: Icon(Icons.add_comment_outlined))))),
        ],
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          didPop ? null : _popBack(context);
        },
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 224, 218, 255),
              borderRadius: BorderRadius.circular(20)),
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                  height: 300,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: _createMap(widget.building.lat, widget.building.lng)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Semantics(
                    label: 'Rating',
                    child: const Text(
                      'Average Rating: ',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  Semantics(
                    label: '$rating stars',
                    child: RatingBar(
                      ignoreGestures: true,
                      initialRating: rating,
                      minRating: 0.5,
                      maxRating: 5,
                      allowHalfRating: true,
                      itemSize: 30,
                      ratingWidget: RatingWidget(
                          full: const Icon(Icons.star),
                          half: const Icon(Icons.star_half),
                          empty: const Icon(Icons.star_border)),
                      onRatingUpdate: (newRating) {
                        rating = newRating;
                      },
                    ),
                  )
                ],
              ),
              Semantics(
                label: '$ratingCount ratings',
                child: Text(
                  'Number of Ratings: $ratingCount',
                  style: const TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  /// This forces the list to rebuild when the length of the reviews changes
                  key: ValueKey(reviews.length),
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    // Build in reverse so that the newest reviews are at the top
                    return ReviewWidget(
                      review: reviews[reviews.length - 1 - index],
                      onEdit: () {
                        setState(() {
                          rating = avgRating(reviews);
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Pops out of view with updating the building with a new rating.
  _popBack(BuildContext context) {
    List<Review> newReviews = [];
    for (Review review in reviews) {
      if (review.review != "" && review.rating != 0) {
        newReviews.add(review.noEditClone());
      }
    }

    Building updatedBuilding = Building.withUpdatedReviews(
        building: widget.building, reviews: newReviews);

    Navigator.pop(context, updatedBuilding);
  }

  // creates flutter map widget to display location of given building
  Widget _createMap(lat, long) {
    //47.65334425420228, -122.30558811163986 = allen center true latlong
    return Center(
      child: FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(lat, long),
            initialZoom: 18,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'dev.potpourri.example',
            ),
            MarkerLayer(markers: [
              Marker(
                  point: LatLng(lat, lng),
                  width: 40,
                  height: 40,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 148, 185, 255),
                        borderRadius: BorderRadius.circular(10), // Add rounding
                        border: Border.all(
                            color: Colors.black, width: 2), // Add border
                      ),
                      child: const Center(
                          child: Text(
                        '🚽',
                        style: TextStyle(
                            fontSize: 28.0, // Set font size
                            color: Colors.black),
                      ))))
            ])
          ]),
    );
  }
}
