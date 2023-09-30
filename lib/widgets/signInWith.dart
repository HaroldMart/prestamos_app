import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prestamos_app/widgets/square_tile.dart';
import '../auth/home.dart';
import '../auth/signin_google.dart';

class SignInWith extends StatefulWidget {
  const SignInWith({super.key});

  @override
  State<SignInWith> createState() => _SignInWithState();
}

class _SignInWithState extends State<SignInWith> {

  Future<void> handleSignInWithGoogle() async {
      try {
        final User? user = await signInWithGoogle();

        if (user != null) {

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) =>
                  const Home(),
            ),
          );
        }
      } catch (error) {
        // Maneja errores aquí
      }
    }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
            onTap: () {
              handleSignInWithGoogle();
            },
            child: const SquareTile(
              imagePath: 'assets/google.png',
            )),

        const SizedBox(width: 15),

        const SquareTile(imagePath: 'assets/apple.png')
      ],
    );
  }
}
