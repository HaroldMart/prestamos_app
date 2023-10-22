import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/payment.dart';

//  FirebaseFirestore db = FirebaseFirestore.instance;
//  final service = PaymentService(db: db);

class PaymentService {
  FirebaseFirestore db = FirebaseFirestore.instance;
  PaymentService({required this.db});

  Future<List<Payment_>> getAll(String clientId, String loanId) async {
    final List<Payment_> payments = [];
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
            var paymentData = docSnapshot.data();
            var payment = Payment_(
              loanId: paymentData['loanId'],
              id: paymentData['id'],
              mount: paymentData['mount'],
              date: paymentData['date']
            );
            payments.add(payment);
          }
        },
      );

      print("Getting payments");
    } catch (e) {
      print("Error getting payments: $e");
    }
    return payments;
  }

  Future<Payment_> get(String clientId, String loanId, String paymentId) async {
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
          loanId: data["loanId"],
          id: data["id"],
          mount: data["mount"],
          date: data["date"]);

      print("Getting payment document");

      return payment;
    } catch (e) {
      print("Error getting payment document: $e");
    }

    return Payment_(loanId: "", mount: 0.0, date: "");
  }

  Future<void> add(String clientId, String loanId, Payment_ payment) async {
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
      await paymentRef.add(payment).then((documentSnapshot) => {
            documentSnapshot.update({"id": documentSnapshot.id}),
            print("Added payment with ID: ${documentSnapshot.id}")
          });
    } catch (e) {
      print("Error adding payment: $e");
    }
  }

  Future<void> update(String clientId, String loanId, String paymentId,
      double mount, String date) async {
    final docRef = db
        .collection("clients")
        .doc(clientId)
        .collection("loans")
        .doc(loanId)
        .collection("payments")
        .doc(paymentId);

    try {
      await docRef.update({
        "loanId": loanId,
        "id": paymentId,
        "mount": mount,
        "date": date
      }).then((value) => print("Payment updated"));
    } catch (e) {
      print("Error updating payment document $e");
    }
  }

  Future<void> delete(String clientId, String loanId, String paymentId) async {
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
