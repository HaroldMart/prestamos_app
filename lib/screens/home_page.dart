import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prestamos_app/screens/login_page.dart';

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
    //  addLoan("EeENXtwRfdd9ZPVURxo5");
    // getLoan("EeENXtwRfdd9ZPVURxo5","h2zapDxq96klJVepM3yu");
    // getAllLoans("EeENXtwRfdd9ZPVURxo5");
    // updateClient("EeENXtwRfdd9ZPVURxo5", "izael", "mivida");
    // updateLoan("EeENXtwRfdd9ZPVURxo5", "h2zapDxq96klJVepM3yu", 20, "50,000");
    // deleteClient("fBxW5slARcT3kdw49PIK");
    // deleteLoan("EeENXtwRfdd9ZPVURxo5", "l6rKhHWJWctyFqYRo18E");
    // final mycliente = getClient("EeENXtwRfdd9ZPVURxo5");
    // print(mycliente);
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
