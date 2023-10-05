import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/loan.dart';

// FirebaseFirestore db = FirebaseFirestore.instance;

class LoanService {
  FirebaseFirestore db;

  LoanService({
    required this.db
  });

  Future<List> getAll(clientId) async {
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

  Future<Loan> get(clientId, loanId) async {
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

  Future<void> add(clientId, loan) async {
  final clientRef =
      db.collection("clients").doc(clientId).collection("loans").withConverter(
            fromFirestore: Loan.fromFirestore,
            toFirestore: (Loan loan, options) => loan.toFirestore(),
          );

  await clientRef.add(loan).then((documentSnapshot) =>
      print("Added loan with ID: ${documentSnapshot.id}"));
}

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

  Future<void> deleteLoan(clientId, loanId) async {
  final docRef =
      db.collection("clients").doc(clientId).collection("loans").doc(loanId);

  await docRef.delete().then(
        (doc) => print("Document deleted"),
        onError: (e) => print("Error updating document $e"),
      );
}
}
