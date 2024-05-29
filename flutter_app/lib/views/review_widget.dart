import 'package:flutter/material.dart';
import 'package:flutter_app/models/review_actions/rating_action.dart';
import 'package:flutter_app/models/review_actions/review_action.dart';
import 'package:flutter_app/models/review_actions/text_action.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/review.dart';

class ReviewWidget extends StatefulWidget {
  /// Current review to be displayed
  final Review review;

  /// Function to be called when the review is edited
  final Function() onEdit;

  /// Constructor
  /// Parameters:
  /// review (Review): The review to be displayed.
  /// onEdit (Function): The function to be called when the review is edited.
  ReviewWidget({required this.review, required this.onEdit, super.key});

  /// Initiates state
  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

/// Companion state class for ReviewWidget
class _ReviewWidgetState extends State<ReviewWidget> {
  /// Controller for the text box
  late final TextEditingController myController;
  late final List<ReviewAction> pastActions;
  late final List<ReviewAction> futureActions;
  late double rating;
  late String reviewText;

  /// Builds the widget
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: RatingBar(
                  ignoreGestures: !widget.review.canEdit,
                  initialRating: rating,
                  minRating: 0.5,
                  maxRating: 5,
                  allowHalfRating: true,
                  itemSize: 30,
                  ratingWidget: RatingWidget(
                      full: const Icon(Icons.star),
                      half: const Icon(Icons.star_half),
                      empty: const Icon(Icons.star_border)),
                  onRatingUpdate: (newRating) {
                    if (widget.review.canEdit) {
                      futureActions.clear();
                      pastActions.add(RatingAction(newRating));
                      setRating();
                      widget.onEdit();
                    }
                  },
                ),
              ),
              if (widget.review.canEdit) ...[insertUndoRedoButtons()],
            ],
          ),
          TextField(
            enabled: widget.review.canEdit,
            controller: myController,
            keyboardType: TextInputType.multiline,
            style: const TextStyle(color: Colors.black),
            maxLines: 5,
            onChanged: (text) {
              futureActions.clear();
              pastActions.add(TextAction(text));
              widget.review.review = text;
              setReviewText();
              widget.onEdit();
            },
            decoration: InputDecoration(
              hintText: 'Enter your review here',
              label: widget.review.canEdit
                  ? null
                  : const Text('Left by verified user'),
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  setRating() {
    double newRating = widget.review.rating;
    if (widget.review.canEdit) {
      final idx =
          pastActions.lastIndexWhere((element) => element is RatingAction);
      if (idx == -1) {
        newRating = 0;
      } else {
        newRating = (pastActions[idx] as RatingAction).rating;
      }
      setState(() {
        rating = newRating;
      });
      widget.review.rating = newRating;
    }
  }

  setReviewText() {
    String newText = widget.review.review;
    if (widget.review.canEdit) {
      final idx =
          pastActions.lastIndexWhere((element) => element is TextAction);
      if (idx == -1) {
        newText = "";
      } else {
        newText = (pastActions[idx] as TextAction).text;
      }
      setState(() {
        reviewText = newText;
        myController = TextEditingController(text: reviewText);
      });
    }
  }

  Widget insertUndoRedoButtons() {
    return Row(
      children: [
        IconButton(
            onPressed: pastActions.isEmpty ? null : _undo,
            icon: Icon(Icons.undo)),
        IconButton(
            onPressed: futureActions.isEmpty ? null : _redo,
            icon: Icon(Icons.redo)),
      ],
    );
  }

  void _undo() {
    if (pastActions.isNotEmpty) {
      final action = pastActions.removeLast();
      futureActions.add(action);
      if (action is RatingAction) {
        setRating();
      } else if (action is TextAction) {
        setReviewText();
      }
    }
  }

  void _redo() {
    if (futureActions.isNotEmpty) {
      final action = futureActions.removeLast();
      pastActions.add(action);
      if (action is RatingAction) {
        setRating();
      } else if (action is TextAction) {
        setReviewText();
      }
    }
  }

  /// Initializes state with AssignmentEntry's current comments in the text box
  @override
  void initState() {
    super.initState();
    reviewText = widget.review.review;
    myController = TextEditingController(text: reviewText);
    rating = widget.review.rating;
    pastActions = [];
    futureActions = [];
  }

  /// Deconstructor, disposes of the controller
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }
}
