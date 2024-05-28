import 'dart:math';

import 'package:flutter_app/models/review.dart';
import 'package:json_annotation/json_annotation.dart';

part 'building.g.dart';
// https://docs.flutter.dev/data-and-backend/serialization/json

@JsonSerializable()
class Building {
  final String _abbr;
  final String _name;
  final double _lat;
  final double _lng;
  final int _rating;
  late final List<Review> _reviews;
  @JsonKey(name: 'ratings')
  final int _ratingCount;

  /// Constructors

  factory Building(
      {required String abbr,
      required String name,
      required double lat,
      required double lng,
      required int rating,
      required int ratingCount}) {
    return Building.all(
        abbr: abbr,
        name: name,
        lat: lat,
        lng: lng,
        rating: rating,
        ratingCount: ratingCount,
        reviews: _generateMockReviews(ratingCount));
  }

  Building.all({
    required abbr,
    required name,
    required lat,
    required lng,
    required rating,
    required ratingCount,
    required reviews,
  })  : _abbr = abbr,
        _name = name,
        _lat = lat,
        _lng = lng,
        _rating = rating,
        _ratingCount = ratingCount,
        _reviews = reviews;

  factory Building.withUpdatedReviews(
      {required Building building, required reviews}) {
    int numberOfReviews = reviews.length;
    int avgRating = 0;
    if (numberOfReviews > 0) {
      int totalRating = 0;
      for (Review review in reviews) {
        totalRating += review.rating;
      }
      /** rating should probably be a double */
      avgRating = (totalRating / numberOfReviews).round();
    }
    return Building.all(
        abbr: building.abbr,
        name: building.name,
        lat: building.lat,
        lng: building.lng,
        rating: avgRating,
        ratingCount: numberOfReviews,
        reviews: reviews);
  }

  factory Building.fromJson(Map<String, dynamic> json) =>
      _$BuildingFromJson(json);
  Map<String, dynamic> toJson() => _$BuildingToJson(this);

  /// Getters
  String get abbr => _abbr;
  String get name => _name;
  double get lat => _lat;
  double get lng => _lng;
  int get rating => _rating;
  int get ratingCount => _ratingCount;
  List<Review> get reviews => List.from(_reviews);

  /// Instance Methods

  /// From food finder TODO cite in readme
  double distanceFrom({required double lat, required double lng}) {
    // pythagorean theorem
    double a = this.lat - lat;
    double b = this.lng - lng;
    double c = sqrt(_squared(a) + _squared(b));
    return c;
  }

  double distanceInMeters({required double lat, required double lng}) {
    return 111139 * distanceFrom(lat: lat, lng: lng);
  }

  num _squared(num x) {
    return x * x;
  }
}

/// Helper method for generating mock reviews
List<Review> _generateMockReviews(int count) {
  Map<int, String> ratingMap = {
    1: "This place suxxxxxx broooooo",
    2: "Bro what the heck is this place?",
    3: "Idk if the tuition is worth it for this place",
    4: "This place is pretty good, I guess",
    5: "Very epic, I like it here"
  };

  List<Review> reviews = [];
  for (int i = 0; i < count; i++) {
    int randomRating = Random().nextInt(5) + 1;
    reviews.add(Review(
        review: ratingMap[randomRating] ?? "Example review.",
        rating: randomRating,
        canEdit: false));
  }
  return reviews;
}
