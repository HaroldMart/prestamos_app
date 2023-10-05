import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/loan.dart';
import '../models/payment.dart';

//  FirebaseFirestore db = FirebaseFirestore.instance;
//  final service = PaymentService(db: db);

class PaymentService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  PaymentService({
    required this.db
  });

  Future<List> getAll(clientId, loanId) async {
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

  Future<Payment_> get(clientId, loanId, paymentId) async {
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

  Future<void> add(clientId, loanId, payment) async {
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

  Future<void> update(clientId, loanId, mount, date) async {
    final docRef =
        db.collection("clients").doc(clientId).collection("loans").doc(loanId);

    await docRef.update({"loanId": loanId, "mount": mount, "date": date}).then(
        (value) => print("DocumentSnapshot successfully updated!"),
        onError: (e) => print("Error updating document $e"));
  }

  Future<void> delete(clientId, loanId, paymentId) async {
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
}
