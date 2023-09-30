import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prestamos_app/screens/login_page.dart'; // Asegúrate de importar tu pantalla de inicio de sesión

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  Future<void> signUserOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    } catch (e) {
      print("Error al cerrar sesión: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            onPressed: () {
              signUserOut(context);
            },
            icon: const Icon(Icons.logout),
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text(
          "LOGGED IN AS:  ${user.email!}",
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
