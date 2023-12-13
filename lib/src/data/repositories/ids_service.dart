import 'package:shared_preferences/shared_preferences.dart';

class IdsService {
  static const _idsKey = 'idsKey';

  List<int> listaIds = [1011334, 1011337, 1010674, 1010802];

  Future<void> saveIds() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        _idsKey, listaIds.map((id) => id.toString()).toList());
  }

  Future<void> loadIds() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIds = prefs.getStringList(_idsKey);
    if (savedIds != null) {
      listaIds = savedIds.map((id) => int.parse(id)).toList();
    }
  }

  void addId(int id) {
    listaIds.add(id);
    saveIds();
  }

  void removeId(int id) {
    listaIds.remove(id);
    saveIds();
  }
}
