import 'package:cloud_firestore/cloud_firestore.dart';

class Payment_ {
  String loanId;
  String? id;
  double mount;
  String date;

  Payment_({
    required this.loanId, 
    this.id, 
    required this.mount, 
    required this.date
  });

  factory Payment_.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Payment_(
        loanId: data?['loanId'],
        id: data?['id'],
        mount: data?['mount'],
        date: data?['date']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "loanId": loanId,
      "id": id,
      "mount": mount,
      "date": date,
    };
  }
}
