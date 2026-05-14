/// User model representing a registered user in the application
class User {
  final String fullName;
  final String email;
  final String password;

  User({
    required this.fullName,
    required this.email,
    required this.password,
  });

  /// Creates a copy of the user with updated fields
  User copyWith({
    String? fullName,
    String? email,
    String? password,
  }) {
    return User(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
