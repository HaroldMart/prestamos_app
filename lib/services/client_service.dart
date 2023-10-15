import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/client.dart';

//  FirebaseFirestore db = FirebaseFirestore.instance;
//  final service = ClientService(db: db);

class ClientService {
  FirebaseFirestore db;

  ClientService({required this.db});

  Future<List<Client>> getAll() async {
    List<Client> clients = [];
    final dbRef = db.collection("clients");

    try {
      await dbRef.get().then((querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          var clientData = docSnapshot.data();
          var client = Client(
            id: clientData['id'],
            idUser: clientData['idUser'],
            name: clientData['name'],
            lastName: clientData['lastName'],
            phone: clientData['phone'],
            document: clientData['document'],
            address: clientData['address'],
          );
          clients.add(client);
        }
      });

      print("Getting clients");
    } catch (e) {
      print("Error getting clients: $e");
    }

    return clients;
  }

  Future<Client> get(String clientId) async {
    final docRef = db.collection("clients").doc(clientId);

    try {
      final doc = await docRef.get();
      final data = doc.data() as Map<String, dynamic>;

      final client = Client(
        id: data['id'],
        idUser: data['idUser'],
        name: data["name"],
        lastName: data["lastName"],
        phone: data["phone"],
        document: data["document"],
        address: data["address"],
      );

      print('Getting client.');

      return client;
    } catch (e) {
      print("Error getting client document: $e");

      return Client(
        id: "",
        idUser: "",
        name: "",
        lastName: "",
        phone: "",
        document: "",
        address: "",
      );
    }
  }

  Future<void> add(Client client) async {
    final dbRef = db.collection("clients").withConverter(
          fromFirestore: Client.fromFirestore,
          toFirestore: (Client client, options) => client.toFirestore(),
        );
    try {
      await dbRef.add(client).then((documentSnapshot) => {
            documentSnapshot.update({"id": documentSnapshot.id}),
            print("Added client with ID: ${documentSnapshot.id}"),
          });
    } catch (e) {
      print("Error adding client: $e");
    }
  }

  Future<void> update(String clientId, String userId, String clientName, String clientLastName,
      String clientPhone, String clientDocument, String clientAddress) async {
    final docRef = db.collection("clients").doc(clientId);

    try {
      await docRef.update({
        "id": clientId,
        "idUser": userId,
        "name": clientName,
        "lastName": clientLastName,
        "phone": clientPhone,
        "document": clientDocument,
        "address": clientAddress
      }).then((value) => print("Client updated"));
    } catch (e) {
      print("Error updating client document $e");
    }
  }

  Future<void> delete(String clientId) async {
    final docRef = db.collection("clients").doc(clientId);

    try {
      await docRef.delete().then((doc) => print("Client deleted"));
    } catch (e) {
      print("Error deleting client $e");
    }
  }
}
