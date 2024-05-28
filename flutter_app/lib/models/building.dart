import 'dart:math';

import 'package:flutter_app/models/review.dart';
import 'package:json_annotation/json_annotation.dart';
import '../utils/rating_helper.dart';

part 'building.g.dart';
// https://docs.flutter.dev/data-and-backend/serialization/json

@JsonSerializable()
class Building {
  final String _abbr;
  final String _name;
  final double _lat;
  final double _lng;
  final double _rating;
  late final List<Review> _reviews;
  @JsonKey(name: 'ratings')
  final int _ratingCount;

  /// Constructors

  factory Building(
      {required String abbr,
      required String name,
      required double lat,
      required double lng,
      required int ratingCount}) {
    List<Review> reviews = generateMockReviews(ratingCount);
    double rating = avgRating(reviews);

    return Building.all(
        abbr: abbr,
        name: name,
        lat: lat,
        lng: lng,
        rating: rating,
        ratingCount: ratingCount,
        reviews: reviews);
  }

  Building.all({
    required String abbr,
    required String name,
    required double lat,
    required double lng,
    required double rating,
    required int ratingCount,
    required List<Review> reviews,
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

    return Building.all(
        abbr: building.abbr,
        name: building.name,
        lat: building.lat,
        lng: building.lng,
        rating: avgRating(reviews),
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
  double get rating => _rating;
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
