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
  );

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
Future<String> getClient(clientId) async {
  final docRef = db.collection("clients").doc(clientId);

  await docRef.get().then((DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    print(data);
    return data;
  }, onError: (e) => print("error getting client document: $e"));

  return "";
}

// Actualiza un cliente
Future<void> updateClient(clientId, clientName, clientLastName) async {
  final docRef = db.collection("clients").doc(clientId);

  await docRef.update({"name": clientName, "lastName": clientLastName}).then(
      (value) => print("DocumentSnapshot successfully updated!"),
      onError: (e) => print("Error updating document $e"));
}

// Elimina un cliente
Future<void> deleteClient(clientId) async {
  final docRef = db.collection("clients").doc(clientId);

  await docRef.delete().then(
      (doc) => print("Document deleted"),
      onError: (e) => print("Error updating document $e"),
    );
}

// Trae todos los prestamos 
Future<List> getAllLoans(clientId) async {
  final docRef = db.collection("clients").doc(clientId).collection("loans");
  final loans = [];

  await docRef.get().then(
    (querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        loans.add(docSnapshot.data());
      }
    },
    onError: (e) => print("Error completing: $e"),
  );
  print(loans);
  return loans;
}

// Agrega nuevo prestamo
Future<void> addLoan(clientId) async {
  final loan = Loan(
      clientId: clientId,
      clientName: "alma",
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

// Trae datos de un prestamo
Future<String> getLoan(clientId, loanId) async {
  final docRef =
      db.collection("clients").doc(clientId).collection("loans").doc(loanId);

  await docRef.get().then((DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    print(data);
    return data;
  }, onError: (e) => print("error getting loan document: $e"));

  return "";
}

// Actualiza un prestamo
Future<void> updateLoan(clientId, loanId, interest, mount) async {
  final docRef = db.collection("clients").doc(clientId).collection("loans").doc(loanId);

  await docRef.update({"interest": interest, "mount": mount}).then(
      (value) => print("DocumentSnapshot successfully updated!"),
      onError: (e) => print("Error updating document $e"));
}

// Elimina un prestamo
Future<void> deleteLoan(clientId, loanId) async {
  final docRef = db.collection("clients").doc(clientId).collection("loans").doc(loanId);

  await docRef.delete().then(
      (doc) => print("Document deleted"),
      onError: (e) => print("Error updating document $e"),
    );
}