import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prestamos_app/models/client.dart';
import 'package:prestamos_app/models/payment.dart';
import 'package:prestamos_app/services/loan_service.dart';
import 'package:prestamos_app/services/payment_service.dart';
import '../models/loan.dart';

class LoanDetailsPage extends StatefulWidget {
  const LoanDetailsPage(this.clientId, this.loan, {super.key});

  final String? clientId;
  final Loan loan;

  @override
  State<LoanDetailsPage> createState() => _LoanDetailsPage();
}

class _LoanDetailsPage extends State<LoanDetailsPage> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Payment_> payments = [];
  late Payment_ loan;

  @override
  void initState() {
    super.initState();
    getAllPayments(widget.clientId, widget.loan.id);
  }

  Future<void> getAllPayments(clientId, loanId) async {
    final service = PaymentService(db: db);
    final List<Payment_> data = await service.getAll(clientId, loanId);
    setState(() {
      payments = data;
      print(payments.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.loan.mount.toString()),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Column(
          children: [
            Center(child: Text("Id: ${widget.loan.id}")),
            Center(child: Text("Id del cliente: ${widget.loan.clientId}")),
            Center(child: Text("Monto: ${widget..loan.mount}")),
            Center(child: Text("Interes: ${widget.loan.interest}")),
            Center(child: Text("Pago mensual: ${widget.loan.monthlyPayment}")),
            Center(child: Text("Total de pagos mensuales: ${widget.loan.totalMonthlyPayment}")),
            Center(child: Text("Total: ${widget.loan.total}")),
            Center(child: Text("Mota: ${widget.loan.lateFee}")),
            Center(child: Text("Fecha: ${widget.loan.date}")),
            Center(child: Text("Esta pagado el prestamo?: ${widget.loan.isPaid}")),
       ListView.builder(
        shrinkWrap: true,
                itemCount: payments.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text("Pago de: ${payments[index].mount.toString()}"),
                    subtitle: Text("Fecha de pago: ${payments[index].date}"),
                  );
                },
              ),
            
          ],
        ));
  }
}
