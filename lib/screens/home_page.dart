import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prestamos_app/models/payment.dart';
import 'package:prestamos_app/screens/login_page.dart';
import 'package:prestamos_app/services/client_service.dart';
import 'package:prestamos_app/services/loan_service.dart';
import 'package:prestamos_app/services/payment_service.dart';
import '../models/client.dart';
import '../models/loan.dart';

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

    void inventando() async {
      // instancia de firebase
      FirebaseFirestore db = FirebaseFirestore.instance;
      final service = PaymentService(db: db);
      final clientService = ClientService(db: db);

      // payment methods --------
      // final payment = Payment_(
      //   loanId: "h2zapDxq96klJVepM3yu",
      //   mount: 3000.4, 
      //   date: "hoy");
      // final miop = await service.getAll("EeENXtwRfdd9ZPVURxo5", "h2zapDxq96klJVepM3yu");  // miop.forEach((element) {print(element);});
      // final miop = await service.get("EeENXtwRfdd9ZPVURxo5", "h2zapDxq96klJVepM3yu", "dh8a7z93cexWzsu8mFsk");  // print(miop.date);
      // final miop = await service.add("EeENXtwRfdd9ZPVURxo5", "h2zapDxq96klJVepM3yu", payment); 
      // final miop = await service.update("EeENXtwRfdd9ZPVURxo5", "h2zapDxq96klJVepM3yu", "fKV36bx0YxSsWbIyAYoQ", 400, "mivida");
      // final miop = await service.delete("EeENXtwRfdd9ZPVURxo5", "h2zapDxq96klJVepM3yu", "PduKlwZZciy8TpqAYd4D");


      // loan methods --------
      //   final loan =  Loan(
      //   clientId: "EeENXtwRfdd9ZPVURxo5",
      //   clientName: "izael",
      //   interest: 10,
      //   date: "mivida",
      //   mount: 304566,
      //   payment: 0,
      //   monthlyPayment: 300,
      //   total: 4902,
      //   totalMonthlyPayment: 10,
      //   lateFee: 30
      // );
      // final miop = await service.getAll("EeENXtwRfdd9ZPVURxo5");  // miop.forEach((element) {print(element);});
      // final miop = await service.get("EeENXtwRfdd9ZPVURxo5", "pCYMQVG4ooBfbsgSf7Hu");  // print(miop.clientName);
      // final miop = await service.add("EeENXtwRfdd9ZPVURxo5", loan);
      // final miop = await service.update("EeENXtwRfdd9ZPVURxo5", "h2zapDxq96klJVepM3yu", "izael", 304566, 10, 400, 20, 40000, 500, "no c", 200);
      // final miop = await service.delete("EeENXtwRfdd9ZPVURxo5", "h2zapDxq96klJVepM3yu");
     

      // client methods --------
      //   final client = Client(
      //   name: "mvida",
      //   lastName: "suvida",
      //   document: "03094830948",
      //   address: "su calle",
      //   phone: "89504583554"
      // );
      // final clients = await clientService.getAll(); 
      // clients.forEach((element) {
      //   print(element);
      // });
      // final miop = await clientService.get("EeENXtwRfdd9ZPVURxo5");  // print(miop.name);
      // final miop = await clientService.update("3SMaB3U2APDv2ThFq7Ju", "izael", "oo", "09820394324", "33333", "la esquina");
      // final miop = await clientService.delete("3SMaB3U2APDv2ThFq7Ju");
    };

    inventando();

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Text(
          "LOGGED IN AS:  ${user.email!}",
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
