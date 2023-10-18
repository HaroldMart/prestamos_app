import 'package:cloud_firestore/cloud_firestore.dart';

class Loan {
  String clientId;
  String? id;
  double mount; // monto total a prestar
  double? interest; // intereses del prestamo
  double monthlyPayment; // cuotas mensuales
  double totalMonthlyPayment; // total de cuotas mensuales
  double total;
  int? lateFee; // mora a cobrar por si se pasa del limite de pago de una cuota
  String date; // fecha en que se realizo el prestamo
  bool isPaid; // si es true, el prestamo ya se pago por completo, de lo contrario es false

  Loan(
      {required this.clientId,
      this.id,
      required this.mount,
      this.interest,
      required this.monthlyPayment,
      required this.totalMonthlyPayment,
      required this.total,
      this.lateFee,
      required this.date,
      required this.isPaid});

  factory Loan.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Loan(
        clientId: data?['clientId'],
        id: data?['id'],
        mount: data?['mount'],
        interest: data?['interest'],
        monthlyPayment: data?['monthlyPayment'],
        totalMonthlyPayment: data?['totalMonthlyPayment'],
        total: data?['total'],
        lateFee: data?['lateFee'],
        date: data?['date'],
        isPaid: data?['isPaid']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "clientId": clientId,
      "id": id,
      "mount": mount,
      "interest": interest,
      "monthlyPayment": monthlyPayment,
      "totalMonthlyPayment": totalMonthlyPayment,
      "total": total,
      "lateFee": lateFee,
      "date": date,
      "isPaid": isPaid,
    };
  }
}
