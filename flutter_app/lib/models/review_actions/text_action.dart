import 'package:flutter_app/models/review_actions/review_action.dart';

/// This class represents the action of editing text of a review
class TextAction extends ReviewAction {
  /// The new text to be set
  final String text;

  /// Constructor
  /// Parameters:
  /// newText (String): the text to be set.
  TextAction(this.text);
}
