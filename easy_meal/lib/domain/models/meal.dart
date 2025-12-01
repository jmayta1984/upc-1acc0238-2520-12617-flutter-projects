class Meal {
  final String id;
  final String name;
  final String posterPath;
  final bool isFavorite;

  const Meal({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.isFavorite,
  });

  Meal copyWith({
    String? id,
    String? name,
    String? posterPath,
    bool? isFavorite,
  }) {
    return Meal(
      id: id ?? this.id,
      name: name ?? this.name,
      posterPath: posterPath ?? this.posterPath,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
