import 'package:cloud_firestore/cloud_firestore.dart';

import 'loan.dart';

class Client {
  String name; // nombre
  String lastName; // apellido
  int phone; // numero de telefono
  int document; // cedula
  String direction;

  Client(
      {required this.name,
      required this.lastName,
      required this.phone,
      required this.document,
      required this.direction,});

  factory Client.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Client(
        name: data?['name'],
        lastName: data?['lastName'],
        phone: data?['phone'],
        document: data?['document'],
        direction: data?['direction']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "lastName": lastName,
      "phone": phone,
      "document": document,
      "direction": direction,
    };
  }
}
