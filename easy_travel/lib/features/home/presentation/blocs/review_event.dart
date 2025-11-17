abstract class ReviewEvent {
  const ReviewEvent();
}

class GetReviews extends ReviewEvent {
  final int id;
  const GetReviews({required this.id});
}

class AddReview extends ReviewEvent {
  final String token;

  const AddReview({required this.token});
}
