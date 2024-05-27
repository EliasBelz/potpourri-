import 'dart:math';

import 'package:flutter_app/models/review.dart';
import 'package:json_annotation/json_annotation.dart';

part 'building.g.dart';
// https://docs.flutter.dev/data-and-backend/serialization/json

@JsonSerializable()
class Building {
  final String abbr;
  final String name;
  final double lat;
  final double lng;
  final int rating;
  final List<Review> reviews = [
    Review(review: "this is a review", rating: 5),
    Review(review: "This is another review", rating: 3)
  ];

  @JsonKey(name: 'ratings')
  final int ratingCount;

  Building({
    required this.abbr,
    required this.name,
    required this.lat,
    required this.lng,
    required this.rating,
    required this.ratingCount,
  });

  Building.withUpdatedRatings(
      {required Building building,
      required this.abbr,
      required this.name,
      required this.lat,
      required this.lng,
      required this.rating,
      required this.ratingCount});

  factory Building.fromJson(Map<String, dynamic> json) =>
      _$BuildingFromJson(json);
  Map<String, dynamic> toJson() => _$BuildingToJson(this);

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
