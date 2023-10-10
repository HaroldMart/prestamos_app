import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prestamos_app/models/client.dart';
import '../services/client_service.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({super.key});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  final GlobalKey<FormState> _clientFormKey = GlobalKey<FormState>();

  FirebaseFirestore db = FirebaseFirestore.instance;
  List clients = [];

  getAllClients() async {
    final service = ClientService(db: db);
    final List<Client> data = await service.getAll();
      
    setState(() {
      clients = data;
    });
  }

  var client = Client(
    name: '', 
    lastName: '', 
    phone: '', 
    document: '', 
    address: ''
  );

  @override
  Widget build(BuildContext context) {

    getAllClients();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: clients.length,
          itemBuilder: (BuildContext context,int i){
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 222, 220, 220),
                        spreadRadius: 4,
                        blurRadius: 7,
                        offset: Offset(0, 2),
                      )
                    ]
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    title: Text('${clients[i].name} ${clients[i].lastName}'),
                    subtitle: Text('${clients[i].address}'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: (){
                      
                    },
                    onLongPress: (){},
                  ),
                ),
                const SizedBox(height: 15),
              ],
            );
          }),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _dialogBuilder(context);
          },
          child: const Icon(Icons.add)),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: const Text('Añadir cliente'),
            content: Form(
                key: _clientFormKey,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Nombre',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          // filled: true,
                          // fillColor: Color.fromARGB(255, 242, 255, 227),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'No dejes este campo vacio';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            client.name = value.toString();
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Apellido',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'No dejes este campo vacio';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            client.lastName = value.toString();
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Teléfono',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'No dejes este campo vacio';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            client.phone = value.toString();
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Cédula',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'No dejes este campo vacio';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            client.document = value.toString();
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Dirección',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'No dejes este campo vacio';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            client.address = value.toString();
                          });
                        },
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancelar')),
                          FilledButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(color: Colors.green)))),
                              onPressed: () {
                                setState(() {
                                  if (_clientFormKey.currentState!.validate()) {
                                    _clientFormKey.currentState!.save();
                                    
                                    final service = ClientService(db: db);
                                    service.add(client);
                                    
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Cliente agregado exitosamente.')),
                                    );
                                    Navigator.of(context).pop();
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Error al agregar cliente.')),
                                  );
                                });
                              },
                              child: const Text('Aceptar'))
                        ],
                      )
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }
}
