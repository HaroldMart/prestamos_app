import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/client.dart';
import '../models/loan.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

// -------------------- Datos de Cliente --------------------

// Trae todos los clientes
Future<List> getAllClients() async {
  List clients = [];

  await db.collection("clients").get().then(
    (querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        clients.add(docSnapshot.data());
      }
    },
    onError: (e) => print("Error completing: $e"),
  );

  print(clients);
  return clients;
}

// Agrega un cliente
Future<void> addClient() async {
  final client = Client(
      name: "izael",
      lastName: "morrobel",
      phone: 32423940023,
      document: 432495249520,
      nationality: "haitiano como en brawhl",
      direction: "lejisimo, Santo domingo",
      loans: []);

  final dbRef = db.collection("clients").withConverter(
        fromFirestore: Client.fromFirestore,
        toFirestore: (Client client, options) => client.toFirestore(),
      );

  await dbRef.add(client).then((documentSnapshot) => {
        documentSnapshot
            .collection("mivida")
            .add({'name': "mividaaa", "hika": "klsk"}),
        print("Added Data with ID: ${documentSnapshot.id}")
      });
}

// Trae datos de un cliente

// Actualiza un cliente

// Elimina un cliente

// Agrega nuevo prestamo
Future<void> addLoan(clientId) async {
  final loan = Loan(
      client: "alma",
      mount: "40,000",
      interest: 10,
      monthlyPayment: 5000,
      totalMonthlyPayment: 20,
      lateFee: 300,
      firstPayment: "2 de septiembre 2023",
      date: "2 de agosto 2023",
      paid: 0);

  final clientRef =
      db.collection("clients").doc(clientId).collection("loans").withConverter(
            fromFirestore: Loan.fromFirestore,
            toFirestore: (Loan loan, options) => loan.toFirestore(),
          );

  await clientRef.add(loan).then((documentSnapshot) =>
      print("Added Data with ID: ${documentSnapshot.id}"));
}
