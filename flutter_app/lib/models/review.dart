class Review {
  String review;
  double rating;
  bool canEdit;

  Review({this.review = "", this.rating = 0, this.canEdit = true});

  Review noEditClone() {
    return Review(review: review, rating: rating, canEdit: false);
  }
}
