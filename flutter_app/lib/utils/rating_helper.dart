import 'dart:math';
import 'package:flutter_app/models/review.dart';

/// Helper method for generating mock reviews with random ratings.
List<Review> generateMockReviews(int count) {
  Map<double, String> ratingMap = {
    0.5: "This place is terrible, don't come here. EVER!!!",
    1: "I would rather be anywhere else than here",
    1.5: "This place suxxxxxx broooooo 💀💀💀",
    2: "What the heck is this place?",
    2.5: "Not the biggest fan of this place... Extremely mediocre",
    3: "Idk if the tuition is worth it for this place",
    3.5: "This place is okay, I guess. Nothing special",
    4: "This place is pretty good, I guess",
    4.5: "This place is pretty epic, I like it here",
    5: "Very epic & clean, would recommend to anyone!"
  };

  List<Review> reviews = [];
  for (int i = 0; i < count; i++) {
    double randomRating =
        ((Random().nextDouble() * 4.5 + 0.5) * 2).roundToDouble() / 2;
    reviews.add(Review(
        review: ratingMap[randomRating] ?? "Example review.",
        rating: randomRating,
        canEdit: false));
  }
  return reviews;
}

/// Helper method for calculating the average rating of a list of reviews.
/// Ignores reviews with a rating of 0 or an empty review.
/// Rounds to the nearest 0.5.
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
  // rounds to nearest 0.5
  return numberOfValidReviews > 0
      ? ((totalRating / numberOfValidReviews) * 2).roundToDouble() / 2
      : 0.0;
}
