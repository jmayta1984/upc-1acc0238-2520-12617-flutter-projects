abstract class FavoritesEvent {
  const FavoritesEvent();
}

class GetAllFavorites extends FavoritesEvent {
  const GetAllFavorites();
}

class RemoveFavorite extends FavoritesEvent {
  final int id;
  const RemoveFavorite({required this.id});
}
