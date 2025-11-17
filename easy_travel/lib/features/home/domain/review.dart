class Review {
  final String comment;
  final int rating;
  final String name;

  const Review({
    required this.comment,
    required this.rating,
    required this.name,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      comment: json['comment'],
      rating: json['rating'],
      name: '${json['user']['lastName']}, ${json['user']['firstName']}',
    );
  }
}
