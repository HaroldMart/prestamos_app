import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prestamos_app/models/payment.dart';
import 'package:prestamos_app/screens/login_page.dart';
import 'package:prestamos_app/services/client_service.dart';
import 'package:prestamos_app/services/payment_service.dart';

import '../models/client.dart';

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
    // FirebaseFirestore db = FirebaseFirestore.instance;
    // final service = ClientService(db: db);
    // final client = Client(
    //   name: "mvida",
    //   lastName: "suvida",
    //   document: "03094830948",
    //   address: "su calle",
    //   phone: "89504583554"
    // );
    // final payment = Payment_(loanId: "h2zapDxq96klJVepM3yu", mount: 40444.5, date: "5 de diciembre");
    // service.add("EeENXtwRfdd9ZPVURxo5", "h2zapDxq96klJVepM3yu", payment);
    // service.add(client);
    // service.update("FGVn85hLKr3UXd1wS2AF", "otravida", "qq", "03094830948", "su calle", "89504583554");
    // final miop = service.getAll();
    // print(miop.toString());
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
