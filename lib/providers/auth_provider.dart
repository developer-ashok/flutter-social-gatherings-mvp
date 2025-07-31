import 'package:flutter/foundation.dart';
import 'package:social_gatherings/models/user.dart';
import 'package:social_gatherings/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;
  bool _isLoggedIn = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;

  AuthProvider() {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    _isLoading = true;
    notifyListeners();

    _isLoggedIn = await AuthService.isLoggedIn();
    if (_isLoggedIn) {
      _currentUser = await AuthService.getCurrentUser();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final success = await AuthService.login(email, password);
    if (success) {
      _currentUser = await AuthService.getCurrentUser();
      _isLoggedIn = true;
    }

    _isLoading = false;
    notifyListeners();
    return success;
  }

  Future<bool> register(String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final success = await AuthService.register(name, email, password);
    if (success) {
      _currentUser = await AuthService.getCurrentUser();
      _isLoggedIn = true;
    }

    _isLoading = false;
    notifyListeners();
    return success;
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    await AuthService.logout();
    _currentUser = null;
    _isLoggedIn = false;

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateProfile(User user) async {
    await AuthService.updateUserProfile(user);
    _currentUser = user;
    notifyListeners();
  }
} 