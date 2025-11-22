import 'dart:async';
import 'package:easy_travel/core/enums/status.dart';
import 'package:easy_travel/features/home/data/review_service.dart';
import 'package:easy_travel/features/home/presentation/blocs/review_event.dart';
import 'package:easy_travel/features/home/presentation/blocs/review_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewService service;
  ReviewBloc({required this.service}) : super(ReviewState()) {
    on<GetReviews>(_getReviews);
    on<SubmitReview>(_submitReview);
  }

  FutureOr<void> _getReviews(
    GetReviews event,
    Emitter<ReviewState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final reviews = await service.getReviewsByDestinationId(event.id);
      emit(state.copyWith(reviews: reviews, status: Status.success));
    } catch (e) {
      emit(state.copyWith(message: e.toString(), status: Status.failure));
    }
  }

  FutureOr<void> _submitReview(
    SubmitReview event,
    Emitter<ReviewState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      await service.submitReview(event.id, event.comment, event.rating);
      final reviews = await service.getReviewsByDestinationId(event.id);
      emit(state.copyWith(reviews: reviews, status: Status.success));
    } catch (e) {
      emit(state.copyWith(message: e.toString(), status: Status.failure));
    }
  }
}
