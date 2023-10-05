import 'package:cloud_firestore/cloud_firestore.dart';

class Payment {
  String loanId;
  double mount;
  String date;

  Payment({required this.loanId, required this.mount, required this.date});

  factory Payment.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Payment(
        loanId: data?['loanId'], mount: data?['mount'], date: data?['date']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "loanId": loanId,
      "mount": mount,
      "date": date,
    };
  }
}
