abstract class ReviewEvent {
  const ReviewEvent();
}

class GetReviews extends ReviewEvent {
  final int id;
  const GetReviews({required this.id});
}

class SubmitReview extends ReviewEvent {
  final int id;
  final String comment;
  final int rating;

  const SubmitReview({
    required this.id,
    required this.comment,
    required this.rating,
  });
}
