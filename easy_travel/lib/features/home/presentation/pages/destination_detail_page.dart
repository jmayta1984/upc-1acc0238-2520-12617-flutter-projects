import 'package:easy_travel/features/home/data/review_service.dart';
import 'package:easy_travel/features/home/domain/destination.dart';
import 'package:easy_travel/features/home/presentation/blocs/review_bloc.dart';
import 'package:easy_travel/features/home/presentation/blocs/review_event.dart';
import 'package:easy_travel/features/home/presentation/widgets/review_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DestinationDetailPage extends StatelessWidget {
  const DestinationDetailPage({super.key, required this.destination});
  final Destination destination;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              child: Padding(
                padding: EdgeInsetsGeometry.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text(
                        'Leave a review',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Review',
                            border: OutlineInputBorder(),
                          ),
                          minLines: 3,
                          maxLines: 3,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ReviewRating(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
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

          BlocProvider(
            create: (context) =>
                ReviewBloc(service: ReviewService())
                  ..add(GetReviews(id: destination.id)),
            child: ReviewList(),
          ),
        ],
      ),
    );
  }
}

class ReviewRating extends StatefulWidget {
  const ReviewRating({super.key});

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
            },

            icon: Icon(
              rating > index ? Icons.star : Icons.star_border,
              color: rating > index ? Colors.amber : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
