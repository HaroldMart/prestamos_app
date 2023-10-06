import 'package:cloud_firestore/cloud_firestore.dart';

class Client {
  String name; // nombre
  String lastName; // apellido
  String phone; // numero de telefono
  String document; // cedula
  String address;

  Client({
    required this.name,
    required this.lastName,
    required this.phone,
    required this.document,
    required this.address,
  });

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
        address: data?['address']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "lastName": lastName,
      "phone": phone,
      "document": document,
      "address": address,
    };
  }
}
