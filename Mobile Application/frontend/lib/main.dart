import 'package:flutter/material.dart';
import 'package:frontend/providers/model_output_provider.dart';
import 'package:frontend/screens/MainScreen.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/auth/signin_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ModelOutputProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/signin',
        routes: {
          '/signin': (context) => const SignInScreen(),
          '/signup': (context) => SignUpScreen(),
          '/forgot-password': (context) => const ForgotPasswordScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/main': (context) => MainScreen(), // Add MainScreen route
        },
      ),
    );
  }
}
