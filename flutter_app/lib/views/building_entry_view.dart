import 'package:flutter/material.dart';
import 'package:flutter_app/models/building.dart';
import 'package:flutter_app/models/review.dart';
import 'package:flutter_app/views/review_widget.dart';
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
  int ratingCount = 0;
  List<Review> reviews = [];

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
          IconButton(
              onPressed: () => {
                    setState(() {
                      reviews.add(Review());
                    })
                  },
              icon: const Icon(Icons.add_comment_outlined)),
        ],
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          return didPop ? {} : _popBack(context);
        },
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
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
                label: '$ratingCount ratings',
                child: Text(
                  'Ratings: $ratingCount',
                  style: const TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.building.reviews.length,
                  itemBuilder: (context, index) {
                    return ReviewWidget(
                        review: widget.building.reviews[index], canEdit: true);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // pops out of view with new rating and an extra rating.
  _popBack(BuildContext context) {
    /** rating should probably be a double */
    final newRating =
        (ratingCount * widget.building.rating + rating) ~/ (ratingCount + 1);
    final newRatings = ratingCount + 1;

    Building updatedBuilding = Building.withUpdatedRatings(
        building: widget.building,
        abbr: widget.building.abbr,
        name: widget.building.name,
        rating: newRating,
        ratingCount: newRatings,
        lat: widget.building.lat,
        lng: widget.building.lng);

    Navigator.pop(context, updatedBuilding);
  }
}
