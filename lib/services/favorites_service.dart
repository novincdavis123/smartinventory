import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const key = "favorites";

  Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }

  Future<void> toggleFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(key) ?? [];

    if (list.contains(id)) {
      list.remove(id);
    } else {
      list.add(id);
    }

    await prefs.setStringList(key, list);
  }
}
