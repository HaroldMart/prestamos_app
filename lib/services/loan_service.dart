import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/loan.dart';

//  FirebaseFirestore db = FirebaseFirestore.instance;
//  final service = LoanService(db: db);

class LoanService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  LoanService({required this.db});

  Future<List<Loan>> getAll(String clientId) async {
    final List<Loan> loans = [];
    final clientRef =
        db.collection("clients").doc(clientId).collection("loans");

    try {
      await clientRef.get().then((querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          var loanData = docSnapshot.data();
          var loan = Loan(
              clientId: loanData['clientId'],
              mount: loanData['mount'],
              interest: loanData['interest'],
              monthlyPayment: loanData['monthlyPayment'],
              totalMonthlyPayment: loanData['totalMonthlyPayment'],
              total: loanData['total'],
              lateFee: loanData['lateFee'],
              date: loanData['date'],
              isPaid: loanData['isPaid']);
          loans.add(loan);
        }
      });

      print("Getting loans");
    } catch (e) {
      print("Error getting loans: $e");
    }
    return loans;
  }

  Future<Loan> get(String clientId, String loanId) async {
    final docRef =
        db.collection("clients").doc(clientId).collection("loans").doc(loanId);

    try {
      final doc = await docRef.get();
      final data = doc.data() as Map<String, dynamic>;

      final loan = Loan(
          clientId: data["clientId"],
          mount: data["mount"],
          interest: data["interest"],
          monthlyPayment: data["monthlyPayment"],
          totalMonthlyPayment: data["totalMonthlyPayment"],
          total: data["total"],
          lateFee: data["lateFee"],
          date: data["date"],
          isPaid: data["isPaid"]);
      print("Getting loan document");

      return loan;

    } catch (e) {
      print("Error getting loan document: $e");
    }

    return Loan(
        clientId: "",
        mount: 0.0,
        interest: 0.0,
        monthlyPayment: 0.0,
        totalMonthlyPayment: 20,
        total: 0.0,
        lateFee: 0,
        date: "",
        isPaid: true);
  }

  Future<void> add(String clientId, Loan loan) async {
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

  Future<void> update(String clientId, String loanId, double mount, double interest,
      double monthlyPayment, double totalMonthlyPayment, double total, int lateFee, String date, bool isPaid) async {
    final docRef =
        db.collection("clients").doc(clientId).collection("loans").doc(loanId);

    try {
      await docRef.update({
        "clientId": clientId,
        "mount": mount,
        "interest": interest,
        "monthlyPayment": monthlyPayment,
        "totalMonthlyPayment": totalMonthlyPayment,
        "total": total,
        "lateFee": lateFee,
        "date": date,
        "isPaid": isPaid
      }).then((value) => print("Loan updated"));

    } catch (e) {
      print("Error updating loan document $e");
    }
  }

  Future<void> delete(String clientId, String loanId) async {
    final docRef =
        db.collection("clients").doc(clientId).collection("loans").doc(loanId);

    try {
      await docRef.delete().then((doc) => print("Loan deleted"));
    } catch (e) {
      print("Error deleting loan $e");
    }
  }
}
