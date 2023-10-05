import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/client.dart';
import '../models/loan.dart';
import '../models/payment.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

// Trae todos los clientes
Future<List> getAllClients() async {
  List clients = [];

  final dbRef = await db.collection("clients");

  dbRef.get().then(
    (querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        clients.add(docSnapshot.data());
      }
    },
    onError: (e) => print("Error getting clients: $e"),
  );

  return clients;
}

// Agrega un cliente
Future<void> addClient(client) async {
  final dbRef = db.collection("clients").withConverter(
        fromFirestore: Client.fromFirestore,
        toFirestore: (Client client, options) => client.toFirestore(),
      );

  await dbRef.add(client).then((documentSnapshot) => {
        documentSnapshot.collection("clients").add(client),
        print("Added client with ID: ${documentSnapshot.id}")
      });
}

// Trae datos de un cliente
Future<Client> getClient(clientId) async {
  final docRef = db.collection("clients").doc(clientId);

  await docRef.get().then((DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    final client = Client(
        name: data["name"],
        lastName: data["lastname"],
        phone: data["phone"],
        document: data["document"],
        direction: data["direction"]);

    return client;
  }, onError: (e) => print("Error getting client document: $e"));

  return Client(name: "", lastName: "", phone: "", document: "", direction: "");
}

// Actualiza un cliente
Future<void> updateClient(clientId, clientName, clientLastName, clientPhone,
    clientDocument, clientDirection) async {
  final docRef = db.collection("clients").doc(clientId);

  await docRef.update({
    "name": clientName,
    "lastName": clientLastName,
    "phone": clientPhone,
    "document": clientDocument,
    "direction": clientDirection
  }).then((value) => print("DocumentSnapshot successfully updated!"),
      onError: (e) => print("Error updating client document $e"));
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
  final loans = [];

  final docRef = db.collection("clients").doc(clientId).collection("loans");

  await docRef.get().then(
    (querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        loans.add(docSnapshot.data());
      }
    },
    onError: (e) => print("Error completing: $e"),
  );
  return loans;
}

// Agrega nuevo prestamo
Future<void> addLoan(clientId, loan) async {
  final clientRef =
      db.collection("clients").doc(clientId).collection("loans").withConverter(
            fromFirestore: Loan.fromFirestore,
            toFirestore: (Loan loan, options) => loan.toFirestore(),
          );

  await clientRef.add(loan).then((documentSnapshot) =>
      print("Added loan with ID: ${documentSnapshot.id}"));
}

// Trae datos de un prestamo
Future<Loan> getLoan(clientId, loanId) async {
  final docRef =
      db.collection("clients").doc(clientId).collection("loans").doc(loanId);

  await docRef.get().then((DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final loan = Loan(
        clientId: data["clientId"],
        clientName: data["clientName"],
        mount: data["mount"],
        interest: data["interest"],
        monthlyPayment: data["monthlyPayment"],
        totalMonthlyPayment: data["totalMonthlyPayment"],
        lateFee: data["lateFee"],
        date: data["date"],
        payment: data["payment"]);
    return loan;
  }, onError: (e) => print("error getting loan document: $e"));

  return Loan(
      clientId: "",
      clientName: "",
      mount: "",
      interest: 0.0,
      monthlyPayment: 0.0,
      totalMonthlyPayment: 0.0,
      lateFee: 0,
      date: "",
      payment: 0.0);
}

// Actualiza un prestamo
Future<void> updateLoan(clientId, loanId, clientName, mount, interest,
    monthlyPayment, totalMonthlyPayment, lateFee, date, payment) async {
  final docRef =
      db.collection("clients").doc(clientId).collection("loans").doc(loanId);

  await docRef.update({
    "clientId": clientId,
    "clientName": clientName,
    "mount": mount,
    "interest": interest,
    "monthlyPayment": monthlyPayment,
    "totalMonthlyPayment": totalMonthlyPayment,
    "lateFee": lateFee,
    "date": date,
    "payment": payment
  }).then((value) => print("DocumentSnapshot successfully updated!"),
      onError: (e) => print("Error updating document $e"));
}

// Elimina un prestamo
Future<void> deleteLoan(clientId, loanId) async {
  final docRef =
      db.collection("clients").doc(clientId).collection("loans").doc(loanId);

  await docRef.delete().then(
        (doc) => print("Document deleted"),
        onError: (e) => print("Error updating document $e"),
      );
}

// Trae todos los pagos
Future<List> getAllPayments(clientId, loanId) async {
  final docRef = db
      .collection("clients")
      .doc(clientId)
      .collection("loans")
      .doc(loanId)
      .collection("payments");

  final payments = [];

  await docRef.get().then(
    (querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        payments.add(docSnapshot.data());
      }
    },
    onError: (e) => print("Error completing: $e"),
  );
  return payments;
}

// Agrega nuevo pago
Future<void> addPayment(clientId, loanId, payment) async {
  final loanRef = db
      .collection("clients")
      .doc(clientId)
      .collection("loans")
      .doc(loanId)
      .collection("payments")
      .withConverter(
        fromFirestore: Loan.fromFirestore,
        toFirestore: (Loan loan, options) => loan.toFirestore(),
      );

  await loanRef.add(payment).then((documentSnapshot) =>
      print("Added payment with ID: ${documentSnapshot.id}"));
}

// Trae datos de un pago
Future<Payment_> getPayment(clientId, loanId, paymentId) async {
  final docRef = db
      .collection("clients")
      .doc(clientId)
      .collection("loans")
      .doc(loanId)
      .collection("payments")
      .doc(paymentId);

  await docRef.get().then((DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    final payment = Payment_(
        loanId: data["LoanId"], mount: data["mount"], date: data["date"]);

    return payment;
  }, onError: (e) => print("error getting loan document: $e"));

  return Payment_(loanId: "", mount: 0.0, date: "");
}

// Actualiza un pago
Future<void> updatePayment(clientId, loanId, mount, date) async {
  final docRef =
      db.collection("clients").doc(clientId).collection("loans").doc(loanId);

  await docRef.update({"loanId": loanId, "mount": mount, "date": date}).then(
      (value) => print("DocumentSnapshot successfully updated!"),
      onError: (e) => print("Error updating document $e"));
}

// Elimina un pago
Future<void> deletePayment(clientId, loanId, paymentId) async {
  final docRef = db
      .collection("clients")
      .doc(clientId)
      .collection("loans")
      .doc(loanId)
      .collection("payments")
      .doc(paymentId);

  await docRef.delete().then(
        (doc) => print("Document deleted"),
        onError: (e) => print("Error updating document $e"),
      );
}
