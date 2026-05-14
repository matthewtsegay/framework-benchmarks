# Flutter Authentication App

A simple Flutter authentication app with Sign Up, Sign In, and Home screens using in-memory storage.

## Features

- **Sign Up**: Register new users with Full Name, Email, and Password
- **Sign In**: Authenticate existing users
- **Home**: Display greeting and welcome button
- **In-Memory Storage**: No backend required - users stored in memory during app session

## Requirements

- Flutter SDK 3.x or later
- Dart 3.0.0 or later

## How to Run

1. Ensure Flutter SDK is installed and configured:
   ```bash
   flutter doctor
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Testing Steps

1. Run the app - it will start on the Sign In page
2. Tap "Sign up" to navigate to the Sign Up page
3. Register with:
   - Full Name: "John Doe"
   - Email: "john@example.com"
   - Password: "123456"
4. After successful signup, you'll be automatically logged in and redirected to the Home page
5. Tap the "Wellcome to Flatter" button to see "Welcome, John Doe!" message
6. You can logout and sign in again using the same credentials (during the same app session)

## Project Structure

```
.
├── lib/
│   ├── main.dart                    # Application entry point
│   ├── models/
│   │   └── user.dart                # User data model
│   ├── services/
│   │   └── user_storage.dart        # User storage service (singleton)
│   ├── screens/
│   │   ├── sign_in_page.dart        # Sign In screen
│   │   ├── sign_up_page.dart        # Sign Up screen
│   │   └── home_page.dart           # Home screen
│   ├── widgets/
│   │   ├── password_field.dart      # Reusable password input widget
│   │   └── loading_button.dart      # Reusable loading button widget
│   ├── utils/
│   │   └── validators.dart          # Form validation utilities
│   └── routes/
│       └── app_routes.dart          # Route configuration
├── pubspec.yaml                     # Flutter project configuration
└── README.md                        # This file
```

## Architecture

The project follows a modular architecture for better maintainability, readability, and testability:

- **Models**: Data classes representing application entities
- **Services**: Business logic and data management (singleton pattern)
- **Screens**: UI pages/screens of the application
- **Widgets**: Reusable UI components
- **Utils**: Utility functions and helpers
- **Routes**: Navigation and routing configuration

## Notes

- Users are stored in memory only - they will be lost when the app is closed
- Password visibility can be toggled using the eye icon
- Form validation ensures all fields are properly filled
- Email validation checks for '@' symbol
- Password must be at least 6 characters long
