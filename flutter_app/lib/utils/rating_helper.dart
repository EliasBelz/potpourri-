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
    int randomRating = Random().nextInt(5) + 1;
    reviews.add(Review(
        review: ratingMap[randomRating] ?? "Example review.",
        rating: randomRating,
        canEdit: false));
  }
  return reviews;
}

int avgRating(List<Review> reviews) {
  int numberOfValidReviews = 0;
  int totalRating = 0;
  for (Review review in reviews) {
    if (review.rating == 0 || review.review == '') {
      continue;
    }
    totalRating += review.rating;
    numberOfValidReviews++;
  }
  /** rating should probably be a double */
  return numberOfValidReviews > 0
      ? (totalRating / numberOfValidReviews).round()
      : 0;
}
