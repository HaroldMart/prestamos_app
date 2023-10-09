import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/loan.dart';
import '../models/payment.dart';

//  FirebaseFirestore db = FirebaseFirestore.instance;
//  final service = PaymentService(db: db);

class PaymentService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  PaymentService({required this.db});

  Future<List> getAll(clientId, loanId) async {
    final payments = [];
    final loanRef = db
        .collection("clients")
        .doc(clientId)
        .collection("loans")
        .doc(loanId)
        .collection("payments");

    try {
      await loanRef.get().then(
        (querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
            payments.add(docSnapshot.data());
          }
        },
      );

      print("Getting payments");
    } catch (e) {
      print("Error getting payments: $e");
    }

    return payments;
  }

  Future<Payment_> get(clientId, loanId, paymentId) async {
    final docRef = db
        .collection("clients")
        .doc(clientId)
        .collection("loans")
        .doc(loanId)
        .collection("payments")
        .doc(paymentId);

    try {
      final doc = await docRef.get();
      final data = doc.data() as Map<String, dynamic>;

      final payment = Payment_(
          loanId: data["loanId"], mount: data["mount"], date: data["date"]);

      print("Getting payment document");

      return payment;
    } catch (e) {
      print("Error getting payment document: $e");
    }

    return Payment_(loanId: "", mount: 0.0, date: "");
  }

  Future<void> add(clientId, loanId, payment) async {
    final paymentRef = db
        .collection("clients")
        .doc(clientId)
        .collection("loans")
        .doc(loanId)
        .collection("payments")
        .withConverter(
          fromFirestore: Payment_.fromFirestore,
          toFirestore: (Payment_ loan, options) => loan.toFirestore(),
        );

    try {
      await paymentRef.add(payment).then((documentSnapshot) =>
          print("Added payment with ID: ${documentSnapshot.id}"));
    } catch (e) {
      print("Error adding payment: $e");
    }
  }

  Future<void> update(clientId, loanId, paymentId, mount, date) async {
    final docRef = db
        .collection("clients")
        .doc(clientId)
        .collection("loans")
        .doc(loanId)
        .collection("payments")
        .doc(paymentId);

    try {
      await docRef
          .update({"loanId": loanId, "mount": mount, "date": date}).then(
              (value) => print("Payment updated"));
    } catch (e) {
      print("Error updating payment document $e");
    }
  }

  Future<void> delete(clientId, loanId, paymentId) async {
    final docRef = db
        .collection("clients")
        .doc(clientId)
        .collection("loans")
        .doc(loanId)
        .collection("payments")
        .doc(paymentId);

    try {
      await docRef.delete().then((doc) => print("Payment deleted"));
    } catch (e) {
      print("Error deleting payment $e");
    }
  }
}
