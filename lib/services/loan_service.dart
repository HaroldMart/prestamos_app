import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/loan.dart';

//  FirebaseFirestore db = FirebaseFirestore.instance;
//  final service = LoanService(db: db);

class LoanService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  LoanService({required this.db});

  Future<List> getAll(clientId) async {
    final loans = [];
    final clientRef =
        db.collection("clients").doc(clientId).collection("loans");

    try {
      await clientRef.get().then((querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          loans.add(docSnapshot.data());
        }
      });

      print("Getting loans");
    } catch (e) {
      print("Error getting loans: $e");
    }

    return loans;
  }

  Future<Loan> get(clientId, loanId) async {
    final docRef =
        db.collection("clients").doc(clientId).collection("loans").doc(loanId);

    try {
      final doc = await docRef.get();
      final data = doc.data() as Map<String, dynamic>;

      final loan = Loan(
          clientId: data["clientId"],
          clientName: data["clientName"],
          mount: data["mount"],
          interest: data["interest"],
          monthlyPayment: data["monthlyPayment"],
          totalMonthlyPayment: data["totalMonthlyPayment"],
           total: data["total"],
          lateFee: data["lateFee"],
          date: data["date"],
          payment: data["payment"]);

      print("Getting loan document");

      return loan;
    } catch (e) {
      print("Error getting loan document: $e");
    }
    return Loan(
        clientId: "",
        clientName: "",
        mount: 0.0,
        interest: 0.0,
        monthlyPayment: 0.0,
        totalMonthlyPayment: 20,
        total: 0.0,
        lateFee: 0,
        date: "",
        payment: 0.0);
  }

  Future<void> add(clientId, loan) async {
    final clientRef = db
        .collection("clients")
        .doc(clientId)
        .collection("loans")
        .withConverter(
          fromFirestore: Loan.fromFirestore,
          toFirestore: (Loan loan, options) => loan.toFirestore(),
        );

    try {
      await clientRef.add(loan).then((documentSnapshot) =>
          print("Added loan with ID: ${documentSnapshot.id}"));
    } catch (e) {
      print("Error adding loan: $e");
    }
  }

  Future<void> update(clientId, loanId, clientName, mount, interest,
      monthlyPayment, totalMonthlyPayment, total, lateFee, date, payment) async {
    final docRef =
        db.collection("clients").doc(clientId).collection("loans").doc(loanId);

    try {
      await docRef.update({
        "clientId": clientId,
        "clientName": clientName,
        "mount": mount,
        "interest": interest,
        "monthlyPayment": monthlyPayment,
        "totalMonthlyPayment": totalMonthlyPayment,
         "total": total,
        "lateFee": lateFee,
        "date": date,
        "payment": payment
      }).then((value) => print("Loan updated"));
    } catch (e) {
      print("Error updating loan document $e");
    }
  }

  Future<void> delete(clientId, loanId) async {
    final docRef =
        db.collection("clients").doc(clientId).collection("loans").doc(loanId);

    try {
      await docRef.delete().then((doc) => print("Loan deleted"));
    } catch (e) {
      print("Error deleting loan $e");
    }
  }
}
