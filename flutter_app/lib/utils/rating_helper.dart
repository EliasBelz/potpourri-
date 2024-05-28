import 'dart:math';

import 'package:flutter_app/models/review.dart';

/// Helper method for generating mock reviews
List<Review> generateMockReviews(int count) {
  Map<int, String> ratingMap = {
    1: "This place suxxxxxx broooooo",
    2: "Bro what the heck is this place?",
    3: "Idk if the tuition is worth it for this place",
    4: "This place is pretty good, I guess",
    5: "Very epic, I like it here"
  };

  List<Review> reviews = [];
  for (int i = 0; i < count; i++) {
    double randomRating =
        ((Random().nextDouble() * 4 + 1) * 2).roundToDouble() / 2;
    reviews.add(Review(
        review: ratingMap[randomRating.toInt()] ?? "Example review.",
        rating: randomRating,
        canEdit: false));
  }
  return reviews;
}

double avgRating(List<Review> reviews) {
  int numberOfValidReviews = 0;
  double totalRating = 0;
  for (Review review in reviews) {
    if (review.rating == 0 || review.review == '') {
      continue;
    }
    totalRating += review.rating;
    numberOfValidReviews++;
  }
  // round to nearest 0.5
  return numberOfValidReviews > 0
      ? ((totalRating / numberOfValidReviews) * 2).roundToDouble() / 2
      : 0.0;
}
