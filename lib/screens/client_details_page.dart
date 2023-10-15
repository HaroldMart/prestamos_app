import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prestamos_app/models/client.dart';
import 'package:prestamos_app/screens/loan_details_page.dart';
import 'package:prestamos_app/services/loan_service.dart';

import '../models/loan.dart';

class ClientDetailsPage extends StatefulWidget {
  const ClientDetailsPage(this.client, {super.key});

  final Client client;

  @override
  State<ClientDetailsPage> createState() => _ClientDetailsPage();
}

class _ClientDetailsPage extends State<ClientDetailsPage> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Loan> loans = [];
  late Loan loan;

  @override
  void initState() {
    super.initState();
    getAllLoans(widget.client.id);
  }

  Future<void> getAllLoans(clientId) async {
    final service = LoanService(db: db);
    final List<Loan> data = await service.getAll(clientId);
    setState(() {
      loans = data;
      print(loans.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.client.name),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Column(
          children: [
            Center(child: Text("Id: ${widget.client.id}")),
            Center(child: Text("Nombre: ${widget.client.name}")),
            Center(child: Text("Apellido: ${widget.client.lastName}")),
            Center(child: Text("Direccion: ${widget.client.address}")),
            Center(child: Text("Cedula: ${widget.client.document}")),
            Center(child: Text("Numero: ${widget.client.phone}")),
       ListView.builder(
        shrinkWrap: true,
                itemCount: loans.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(loans[index].total.toString()),
                    subtitle: Text(loans[index].date),
                    onTap: () {
                           // Envia el objeto de cliente del array a la página de perfil del cliente.
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                LoanDetailsPage(widget.client.id, loans[index])));
                    },
                  );
                },
              ),
            
          ],
        ));
  }
}
