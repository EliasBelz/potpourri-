/// This class represents a review of a building
class Review {
  /// The review text
  String review;

  /// Rating of the review
  double rating;

  /// Whether the review can be edited
  bool canEdit;

  /// Constructor for Review object.
  /// review (string): The review text defaults to empty string.
  /// rating (double): The rating of the review defaults to 0.
  /// canEdit (bool): Whether the review can be edited defaults to true.
  Review({this.review = "", this.rating = 0, this.canEdit = true});

  /// Clones the current Review object, but with canEdit set to false.
  /// Parameters:
  /// review (string): The review text.
  /// rating (double): The rating of the review.
  /// canEdit (bool): Whether the review can be edited.
  Review noEditClone() {
    return Review(review: review, rating: rating, canEdit: false);
  }
}
