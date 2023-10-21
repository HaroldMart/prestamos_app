import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:prestamos_app/models/client.dart';
import 'package:prestamos_app/screens/client_details_page.dart';
import '../services/client_service.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({Key? key}) : super(key: key);

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  
  final GlobalKey<FormState> _clientFormKey = GlobalKey<FormState>();
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Client> clients = [];
  late Client client = Client(idUser: 'no c',name: 'vidia');

  @override
  void initState() {
    super.initState();
    getAllClients();
  }

  Future<void> getAllClients() async {
    final service = ClientService(db: db);
    final List<Client> data = await service.getAll();

    setState(() {
      clients = data;
    });
  }

  String direccionDefault = "no c"; // e que me decia error porque puede ser null xd

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: clients.isEmpty
              ? const Center(
                  child: Text('No hay clientes disponibles.'),
                )
              : ListView.builder(
                  itemCount: clients.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                          '${clients[index].name} ${clients[index].lastName}'),
                      subtitle:
                          Text(clients[index].address ?? direccionDefault),
                      onTap: () { 
                        // Envia el objeto de cliente del array a la página de perfil del cliente.
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ClientDetailsPage(clients[index])));
                      },
                      onLongPress: () {
                        // Agregar aquí la lógica para manejar la pulsación larga en un cliente.
                      },
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _dialogBuilder(context);
        },
        child: const Icon(IconlyBold.addUser),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
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
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: const BorderSide(
                                              color: Colors.green)))),
                              onPressed: () {
                                setState(() {
                                  if (_clientFormKey.currentState!.validate()) {
                                    _clientFormKey.currentState!.save();

                                    FirebaseAuth auth = FirebaseAuth.instance;

                                    client.idUser = auth.currentUser!.uid;

                                    if(client.idUser.isNotEmpty) {
                                      print('id user: ${client.idUser}');

                                        final service = ClientService(db: db);
                                        service.add(client);
                                    }
                                
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Cliente agregado exitosamente.')),
                                    );
                                    Navigator.of(context).pop();
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Error al agregar cliente.')),
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
