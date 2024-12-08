import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const String _userIDKey = 'userId';
  static const String _roleKey = 'role';

  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static Future<void> _save(String key, String value) async {
    await init();
    await _prefs?.setString(key, value);
  }

  static Future<String?> _get(String key) async {
    await init();
    return _prefs?.getString(key);
  }

  // Các phương thức static
  static Future<void> saveUserId(String userId) => _save(_userIDKey, userId);

  static Future<void> saveRole(String role) => _save(_roleKey, role);

  static Future<String?> getUserId() => _get(_userIDKey);

  static Future<String?> getRole() => _get(_roleKey);

  static Future<void> clear({String? key}) async {
    await init();
    if (key != null) {
      await _prefs?.remove(key);
    } else {
      await _prefs?.clear();
    }
  }
}
