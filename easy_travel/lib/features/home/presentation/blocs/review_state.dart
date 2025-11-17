import 'package:easy_travel/core/enums/status.dart';
import 'package:easy_travel/features/home/domain/review.dart';

class ReviewState {
  final Status status;
  final List<Review> reviews;
  final String? message;

  const ReviewState({
    this.status = Status.initial,
    this.reviews = const [],
    this.message,
  });

  ReviewState copyWith({
    Status? status,
    List<Review>? reviews,
    String? message,
  }) {
    return ReviewState(
      status: status ?? this.status,
      reviews: reviews ?? this.reviews,
      message: message ?? this.message,
    );
  }
}
