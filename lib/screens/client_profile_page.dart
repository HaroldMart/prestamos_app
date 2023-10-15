import 'package:flutter/material.dart';
import 'package:prestamos_app/models/client.dart';

class ClientProfilePage extends StatefulWidget {
  const ClientProfilePage(this.client, {super.key});

  final Client client;

  @override
  State<ClientProfilePage> createState() => _ClientProfilePageState();
}

class _ClientProfilePageState extends State<ClientProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.client.name),
          // Agrega el botón de retroceso en la barra de aplicaciones
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(30),
          children: [
            Center(child: Text("Id: ${widget.client.id}")),
            Center(child: Text("Nombre: ${widget.client.name}")),
            Center(child: Text("Apellido: ${widget.client.lastName}")),
            Center(child: Text("Direccion: ${widget.client.address}")),
            Center(child: Text("Cedula: ${widget.client.document}" )),
            Center(child: Text("Numero: ${widget.client.phone}")),
          ],
        ));
  }
}
