import 'package:cloud_firestore/cloud_firestore.dart';

class Loan {
  String clientId;
  String clientName;
  double mount; // monto total a prestar
  double interest; // intereses del prestamo
  double monthlyPayment; // cuotas mensuales
  int totalMonthlyPayment; // total de cuotas mensuales
  double total;
  int lateFee; // mora a cobrar por si se pasa del limite de pago de una cuota
  String date; // fecha en que se realizo el prestamo
  double payment;

  Loan(
      {required this.clientId,
      required this.clientName,
      required this.mount,
      required this.interest,
      required this.monthlyPayment,
      required this.totalMonthlyPayment,
      required this.total,
      required this.lateFee,
      required this.date,
      required this.payment});

  factory Loan.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Loan(
        clientId: data?['clientId'],
        clientName: data?['clientName'],
        mount: data?['mount'],
        interest: data?['interest'],
        monthlyPayment: data?['monthlyPayment'],
        totalMonthlyPayment: data?['totalMonthlyPayment'],
        total: data?['total'],
        lateFee: data?['lateFee'],
        date: data?['date'],
        payment: data?['payment']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "clientId": clientId,
      "clientName": clientName,
      "mount": mount,
      "interest": interest,
      "monthlyPayment": monthlyPayment,
      "totalMonthlyPayment": totalMonthlyPayment,
      "total": total,
      "lateFee": lateFee,
      "date": date,
      "payment": payment,
    };
  }
}
