import 'package:easy_travel/features/home/domain/review.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReviewCard extends StatelessWidget {
  final Review review;
  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    index < review.rating ? Icons.star : Icons.star_border,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Spacer(),
              Text(DateFormat.yMMMMd().format(review.date)),
            ],
          ),
          Text(review.comment),
          Text(review.userName, style: TextStyle(fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }
}
