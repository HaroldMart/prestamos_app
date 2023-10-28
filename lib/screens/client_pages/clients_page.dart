import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:prestamos_app/models/client.dart';
import 'package:prestamos_app/screens/client_pages/client_details_page.dart';
import '../../services/client_service.dart';
import 'package:flutter_scrolling_fab_animated/flutter_scrolling_fab_animated.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({Key? key}) : super(key: key);

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  final GlobalKey<FormState> _clientFormKey = GlobalKey<FormState>();
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Client> clients = [];
  late Client client = Client(idUser: 'no c', name: 'vidia');
  final ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    getAllClients();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future<void> getAllClients() async {
    final service = ClientService(db: db);
    final List<Client> data = await service.getAll();

    setState(() {
      clients = data;
    });
  }

  deleteClient(clientId) {
    final service = ClientService(db: db);
    service.delete(clientId);
  }

  String direccionDefault =
      "no c"; // e que me decia error porque puede ser null xd

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: clients.isEmpty
          ? const Center(
              child: Text('No hay clientes disponibles.'),
            )
          : ListView.builder(
              controller: _scrollController,
              itemCount: clients.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {
                      _buildBottomSheet(index);
                    },
                  ),
                  title:
                      Text('${clients[index].name} ${clients[index].lastName}'),
                  subtitle: Text(clients[index].address ?? direccionDefault),
                  onTap: () {
                     Navigator.of(context).pushNamed('/client_details', arguments: clients[index]);
                  },
                  onLongPress: () {
                    _buildBottomSheet(index);
                  },
                );
              },
            ),
      floatingActionButton: ScrollingFabAnimated(
        icon: const Icon(
          IconlyBold.addUser,
          color: Colors.white,
        ),
        text: const Text(
          'Añadir cliente',
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        color: Colors.green,
        onPress: () {
          _dialogForm(context);
        },
        scrollController: _scrollController,
        animateIcon: false,
        inverted: false,
        width: 190,
        radius: 20,
      ),
    );
  }

  Future<void> _dialogForm(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
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
                                shape: MaterialStateProperty.all(
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

                                  if (client.idUser.isNotEmpty) {
                                    if (kDebugMode) {
                                      print('id user: ${client.idUser}');
                                    }

                                    final service = ClientService(db: db);
                                    service.add(client);

                                    setState(() {
                                      getAllClients();
                                    });
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
        );
      },
    );
  }

  Future<dynamic> _buildBottomSheet(clientIndex) => showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 190,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: ListView(
                  children: [
                    ListTile(
                      leading: const Icon(IconlyBold.edit),
                      title: const Text('Editar'),
                      subtitle: Text('Editar a ${clients[clientIndex].name}'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(IconlyBold.delete),
                      title: const Text('Borrar'),
                      subtitle: Text('Eliminar a ${clients[clientIndex].name}'),
                      onTap: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              title: const Text('Eliminar cliente'),
                              content: Text(
                                  '¿Seguro que quieres eliminar a ${clients[clientIndex].name} ${clients[clientIndex].lastName}?'),
                              actions: [
                                TextButton(
                                  onPressed: () => {
                                    Navigator.pop(context, 'Cancel'),
                                  },
                                  child: const Text('Cancel'),
                                ),
                                FilledButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              side: const BorderSide(
                                                  color: Colors.green)))),
                                  onPressed: () => {
                                    deleteClient(clients[clientIndex].id),
                                    getAllClients(),
                                    Navigator.pop(context, 'Eliminar'),
                                    const SnackBar(
                                      content: Text('Cliente eliminado'),
                                    )
                                  },
                                  child: const Text('Eliminar'),
                                ),
                              ]),
                        );
                      },
                    )
                  ],
                )),
          );
        },
      );
}
