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
