import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_gatherings/models/user.dart';
import 'package:social_gatherings/services/database_service.dart';

class AuthService {
  static const String _userKey = 'current_user';
  static const String _isLoggedInKey = 'is_logged_in';

  // Demo credentials
  static const Map<String, String> _demoCredentials = {
    'john@example.com': 'password123',
    'jane@example.com': 'password123',
    'demo@example.com': 'demo123',
  };

  static Future<bool> login(String email, String password) async {
    // Check demo credentials
    if (_demoCredentials.containsKey(email) && _demoCredentials[email] == password) {
      // Get user from database
      final user = await DatabaseService.getUserByEmail(email);
      if (user != null) {
        await _saveUserSession(user);
        return true;
      }
    }
    return false;
  }

  static Future<bool> register(String name, String email, String password) async {
    // Check if user already exists
    final existingUser = await DatabaseService.getUserByEmail(email);
    if (existingUser != null) {
      return false;
    }

    // Create new user
    final user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      createdAt: DateTime.now(),
    );

    await DatabaseService.createUser(user);
    await _saveUserSession(user);
    return true;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    await prefs.setBool(_isLoggedInKey, false);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  static Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    if (userJson != null) {
      return User.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  static Future<void> _saveUserSession(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
    await prefs.setBool(_isLoggedInKey, true);
  }

  static Future<void> updateUserProfile(User user) async {
    await _saveUserSession(user);
  }
} 