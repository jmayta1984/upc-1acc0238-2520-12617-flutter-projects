import 'package:easy_travel/features/home/domain/destination.dart';
import 'package:easy_travel/features/home/presentation/blocs/review_bloc.dart';
import 'package:easy_travel/features/home/presentation/blocs/review_event.dart';
import 'package:easy_travel/features/home/presentation/widgets/review_list.dart';
import 'package:easy_travel/features/home/presentation/widgets/review_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DestinationDetailPage extends StatelessWidget {
  const DestinationDetailPage({super.key, required this.destination});
  final Destination destination;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showDialogReview(context),
        child: const Icon(Icons.add_comment),
      ),
      body: Column(
        children: [
          Hero(
            tag: destination.id,
            child: Image.network(
              destination.posterPath,
              height: 400,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          ReviewList(),
        ],
      ),
    );
  }

  void _showDialogReview(BuildContext context) {
    int rating = 0;
    String comment = '';
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              context.read<ReviewBloc>().add(
                SubmitReview(
                  id: destination.id,
                  comment: comment,
                  rating: rating,
                ),
              );
              Navigator.pop(context);
            },
            child: Text('Submit'),
          ),
        ],
        content: SingleChildScrollView(
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Leave a review',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                onChanged: (value) => comment = value,
                decoration: InputDecoration(
                  hintText: 'Review',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              ReviewRating(onRatingSelected: (value) => rating = value),
            ],
          ),
        ),
      ),
    );
  }
}
