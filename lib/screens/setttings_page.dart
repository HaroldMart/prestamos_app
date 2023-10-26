import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/login_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Future<void> logOut(BuildContext context) async {
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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 222, 220, 220),
                        spreadRadius: 4,
                        blurRadius: 7,
                        offset: Offset(0, 2),
                      )
                    ]
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.logout_outlined),
                    title: const Text('Cerrar sesión'),
                    subtitle: const Text(''),
                    onTap: (){
                      logOut(context);
                    },
                    onLongPress: (){},
                  ),
                ),
                const SizedBox(height: 15),
              ]
      ),
    );
  }
}
