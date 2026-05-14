import '../models/user.dart';

/// In-memory storage service for managing registered users
/// Uses singleton pattern to maintain state across the application
class UserStorage {
  static final UserStorage _instance = UserStorage._internal();
  factory UserStorage() => _instance;
  UserStorage._internal();

  // Store users as Map<email, User>
  final Map<String, User> _users = {};
  User? _currentUser;

  /// Register a new user
  /// Returns true if registration is successful, false if email already exists
  bool registerUser(String fullName, String email, String password) {
    if (_users.containsKey(email)) {
      return false; // User already exists
    }
    _users[email] = User(
      fullName: fullName,
      email: email,
      password: password,
    );
    return true;
  }

  /// Authenticate a user with email and password
  /// Returns true if credentials are valid, false otherwise
  bool authenticate(String email, String password) {
    final user = _users[email];
    if (user != null && user.password == password) {
      _currentUser = user;
      return true;
    }
    return false;
  }

  /// Get current logged-in user
  User? getCurrentUser() => _currentUser;

  /// Set current user (for auto-login after signup)
  void setCurrentUser(User user) {
    _currentUser = user;
  }

  /// Logout current user
  void logout() {
    _currentUser = null;
  }

  /// Check if a user exists with the given email
  bool userExists(String email) {
    return _users.containsKey(email);
  }

  /// Get all registered users (for testing purposes)
  Map<String, User> getAllUsers() {
    return Map.unmodifiable(_users);
  }

  /// Clear all users (for testing purposes)
  void clearAll() {
    _users.clear();
    _currentUser = null;
  }
}
