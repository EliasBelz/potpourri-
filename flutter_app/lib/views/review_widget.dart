import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/review.dart';

class ReviewWidget extends StatefulWidget {
  final Review review;
  final canEdit;

  const ReviewWidget({required this.review, this.canEdit = true, super.key});

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  late final TextEditingController myController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RatingBar(
            initialRating: widget.review.rating.toDouble(),
            minRating: 1,
            maxRating: 5,
            allowHalfRating: false,
            itemSize: 30,
            ratingWidget: RatingWidget(
                full: const Icon(Icons.star),
                half: const Icon(Icons.star_half),
                empty: const Icon(Icons.star_border)),
            onRatingUpdate: (newRating) {
              if (widget.canEdit) {
                widget.review.rating = newRating.toInt();
              }
            },
          ),
          TextField(
            enabled: widget.canEdit,
            controller: myController,
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            onChanged: (text) {
              widget.review.review = myController.text;
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
