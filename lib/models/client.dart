import 'package:cloud_firestore/cloud_firestore.dart';

class Client {
  String? id;
  String idUser;
  String name;
  String? lastName;
  String? phone;
  String? document;
  String? address;

  Client({
    this.id,
    required this.idUser,
    required this.name,
    this.lastName,
    this.phone,
    this.document,
    this.address,
  });

  factory Client.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Client(
        id: data?['id'],
        idUser: data?['idUser'],
        name: data?['name'],
        lastName: data?['lastName'],
        phone: data?['phone'],
        document: data?['document'],
        address: data?['address']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "idUser": idUser,
      "name": name,
      "lastName": lastName,
      "phone": phone,
      "document": document,
      "address": address,
    };
  }
}
