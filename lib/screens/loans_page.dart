import 'package:flutter/material.dart';
import '../models/client.dart';
import '../models/loan.dart';
class Loans extends StatefulWidget {
   const Loans({super.key});

  @override
  State<Loans> createState() => _LoansState();
}

class _LoansState extends State<Loans> {
   final loans = [

    Client(name: "alma", lastName: "castillo", phone: 32423940023, 
    document: 432495249520, nationality: "dominicano", 
    direction: "calle su madrinasa, Santo domingo",
    loans: [
      Loan(client: "alma", mount: "40,000", interest: 10, monthlyPayment: 5000,
    totalMonthlyPayment: 20, lateFee: 300, firstPayment: "2 de septiembre 2023", 
    date: "2 de agosto 2023", paid: 0)
    ]),

    Client(name: "mivida", lastName: "castillo", phone: 32423940023, 
    document: 432495249520, nationality: "dominicano", 
    direction: "calle su madrinasa, Santo domingo",
    loans: [
      Loan(client: "alma", mount: "40,000", interest: 10, monthlyPayment: 5000,
    totalMonthlyPayment: 20, lateFee: 300, firstPayment: "2 de septiembre 2023", 
    date: "2 de agosto 2023", paid: 0)
    ])
  ];

   String name = '';
   String lastName = '';
   String nationality = '';
   String mount = '';
   int interest = 0;
  
  @override
  Widget build(BuildContext context) {
   return ListView.builder(itemCount:  loans.length, itemBuilder: (context, index) {
       name = loans[index].name;
       lastName = loans[index].lastName;
       nationality = loans[index].nationality;
       mount = loans[index].loans[0].mount;
      interest = loans[index].loans[0].interest.toInt();

      return ListTile(
        leading: const Icon(Icons.person),
        title: Text("$name $lastName"),
        subtitle: Text("Monto prestamo: $mount, $interest% de interes"),
        );
    });
  }
}
