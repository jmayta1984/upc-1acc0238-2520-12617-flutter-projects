import 'package:flutter/material.dart';

class ReviewRating extends StatefulWidget {
  const ReviewRating({super.key, required this.onRatingSelected});
  final void Function(int value) onRatingSelected;

  @override
  State<ReviewRating> createState() => _ReviewRatingState();
}

class _ReviewRatingState extends State<ReviewRating> {
  int rating = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          5,
          (index) => IconButton(
            onPressed: () {
              setState(() {
                rating = index + 1;
              });
              widget.onRatingSelected(rating);
            },

            icon: Icon(
              rating > index ? Icons.star : Icons.star_border,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
