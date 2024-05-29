import 'package:flutter_app/models/review_actions/review_action.dart';

class RatingAction extends ReviewAction {
  /// The new rating to be set
  final double rating;

  /// Constructor
  /// Parameters:
  /// newRating (double): the rating to be set.
  RatingAction(this.rating);
}
