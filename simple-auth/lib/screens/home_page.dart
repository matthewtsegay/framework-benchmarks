import 'package:flutter/material.dart';
import '../routes/app_routes.dart';
import '../services/user_storage.dart';

/// Home Page - Displays greeting and welcome button after successful authentication
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _showWelcomeMessage(BuildContext context) {
    final userStorage = UserStorage();
    final user = userStorage.getCurrentUser();

    if (user != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Welcome!'),
            content: Text('Welcome, ${user.fullName}!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Fallback if user is somehow not set
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User information not found.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _handleLogout(BuildContext context) {
    final userStorage = UserStorage();
    userStorage.logout();
    Navigator.of(context).pushReplacementNamed(AppRoutes.signIn);
  }

  @override
  Widget build(BuildContext context) {
    final userStorage = UserStorage();
    final user = userStorage.getCurrentUser();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _handleLogout(context),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.home,
                size: 80,
                color: Colors.blue,
              ),
              const SizedBox(height: 32),
              if (user != null)
                Text(
                  'Hello, ${user.fullName}!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _showWelcomeMessage(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Wellcome to Flatter'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
