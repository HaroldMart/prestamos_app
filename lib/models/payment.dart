import 'package:cloud_firestore/cloud_firestore.dart';

class Payment_ {
  String loanId;
  double mount;
  String date;

  Payment_({required this.loanId, required this.mount, required this.date});

  factory Payment_.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Payment_(
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
