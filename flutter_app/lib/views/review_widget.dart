import 'package:flutter/material.dart';
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
  const ReviewWidget({required this.review, required this.onEdit, super.key});

  /// Initiates state
  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

/// Companion state class for ReviewWidget
class _ReviewWidgetState extends State<ReviewWidget> {
  /// Controller for the text box
  late final TextEditingController myController;

  /// Builds the widget
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RatingBar(
            ignoreGestures: !widget.review.canEdit,
            initialRating: widget.review.rating,
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
                widget.review.rating = newRating;
                widget.onEdit();
              }
            },
          ),
          TextField(
            enabled: widget.review.canEdit,
            controller: myController,
            keyboardType: TextInputType.multiline,
            style: TextStyle(color: Colors.black),
            maxLines: 5,
            onChanged: (text) {
              widget.review.review = myController.text;
              widget.onEdit();
            },
            decoration: const InputDecoration(
              hintText: 'Enter your review here',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  /// Initializes state with AssignmentEntry's current comments in the text box
  @override
  void initState() {
    super.initState();
    myController = TextEditingController(text: widget.review.review);
  }

  /// Deconstructor, disposes of the controller
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }
}
