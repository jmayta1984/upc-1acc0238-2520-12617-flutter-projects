class Review {
  final String comment;
  final int rating;
  final String userName;
  final DateTime date;

  const Review({
    required this.comment,
    required this.rating,
    required this.userName,
    required this.date,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      comment: json['comment'],
      rating: json['rating'],
      userName: '${json['user']['lastName']}, ${json['user']['firstName']}',
      date: DateTime.parse(json['date']),
    );
  }
}
