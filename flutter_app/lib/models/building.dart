import 'dart:math';
import 'package:flutter_app/models/review.dart';
import 'package:json_annotation/json_annotation.dart';
import '../utils/rating_helper.dart';

part 'building.g.dart';
// https://docs.flutter.dev/data-and-backend/serialization/json

/// This class represents a building on campus
@JsonSerializable()
class Building {
  /// Building abbreviation
  final String _abbr;

  /// Building's full name
  final String _name;

  /// Latitude of the building
  final double _lat;

  /// Longitude of the building
  final double _lng;

  /// Average rating of the building
  final double _rating;

  /// List of reviews of the building
  late final List<Review> _reviews;

  /// Number of ratings of the building
  @JsonKey(name: 'ratings')
  final int _ratingCount;

  /// Constructors

  /// Default constructor
  ///
  /// Parameters:
  /// abbr (String): the abbreviation of the building.
  /// name (String): the full name of the building.
  /// lat (double): the latitude of the building.
  /// lng (double): the longitude of the building.
  /// ratingCount (int): the number of ratings of the building.
  ///
  /// N.B
  /// The rating and reviews of this building are mocked by creating fake reviews
  /// based on the rating count and calculating the average rating from the mock
  /// reviews.
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

  /// Constructor for all fields
  /// parameters:
  /// abbr (String): the abbreviation of the building.
  /// name (String): the full name of the building.
  /// lat (double): the latitude of the building.
  /// lng (double): the longitude of the building.
  /// ratingCount (int): the number of ratings of the building.
  /// reviews (List<Review>): the list of reviews of the building.
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

  /// Returns a copy of the building with updated reviews
  /// parameters:
  /// building (Building): the building to be updated
  /// reviews (List<Review>): the list of reviews to update the building with
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

  /// JSON serialization constructor. Builds a building from JSON
  /// parameters:
  /// json (Map<String, dynamic>): the JSON object to build the building from
  factory Building.fromJson(Map<String, dynamic> json) =>
      _$BuildingFromJson(json);
  Map<String, dynamic> toJson() => _$BuildingToJson(this);

  /// Gets abbreviation of the building
  String get abbr => _abbr;

  /// Gets name of the building
  String get name => _name;

  /// Gets latitude of the building
  double get lat => _lat;

  /// Gets longitude of the building
  double get lng => _lng;

  /// Gets the rating of the building
  double get rating => _rating;

  /// Gets the number of ratings of the building
  int get ratingCount => _ratingCount;

  /// Gets a copy of the reviews of the building
  List<Review> get reviews => List.from(_reviews);
}
