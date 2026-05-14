import 'package:flutter/material.dart';
import '../models/user.dart';
import '../routes/app_routes.dart';
import '../services/user_storage.dart';
import '../utils/validators.dart';
import '../widgets/loading_button.dart';
import '../widgets/password_field.dart';

/// Sign Up Page - Allows new users to register with full name, email, and password
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  final _userStorage = UserStorage();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate a brief delay for better UX
    await Future.delayed(const Duration(milliseconds: 300));

    final fullName = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (_userStorage.registerUser(fullName, email, password)) {
      // Auto-login after successful signup
      final user = User(
        fullName: fullName,
        email: email,
        password: password,
      );
      _userStorage.setCurrentUser(user);

      if (mounted) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      }
    } else {
      if (mounted) {
        _showErrorSnackBar(
          'Email already registered. Please sign in instead.',
        );
      }
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                const Icon(
                  Icons.person_add_outlined,
                  size: 80,
                  color: Colors.blue,
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    hintText: 'Enter your full name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: validateFullName,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  validator: validateEmail,
                ),
                const SizedBox(height: 16),
                PasswordField(
                  controller: _passwordController,
                  hintText: 'Enter your password (min 6 characters)',
                  validator: validatePassword,
                ),
                const SizedBox(height: 24),
                LoadingButton(
                  onPressed: _handleSignUp,
                  isLoading: _isLoading,
                  text: 'Sign Up',
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Already have an account? Sign in'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
