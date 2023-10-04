import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prestamos_app/screens/register_page.dart';
import '../screens/login_page.dart';
import 'home.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            return const Home();
          }
          // user is NOT logged in
          else {
            // return const LoginPage();
            return const RegisterPage();
          }
        },
      ),
    );
  }
}
