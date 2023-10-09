import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/client.dart';

//  FirebaseFirestore db = FirebaseFirestore.instance;
//  final service = ClientService(db: db);

class ClientService {
  FirebaseFirestore db;

  ClientService({required this.db});

  Future<List<Client>> getAll() async {
    final List<Client> clients = [];
    final dbRef = db.collection("clients");

    try {
        await dbRef.get().then((querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
            // Convierte el mapa en un objeto Client
            var clientData = docSnapshot.data();
            var client = Client(
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

  Future<Client> get(clientId) async {
    final docRef = db.collection("clients").doc(clientId);

    try {
      final doc = await docRef.get();
      final data = doc.data() as Map<String, dynamic>;

      final client = Client(
        name: data["name"],
        lastName: data["lastName"],
        phone: data["phone"],
        document: data["document"],
        address: data["address"],
      );

      print("Getting client document");

      return client;
    } catch (e) {
      print("Error getting client document: $e");
      return Client(
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
      await dbRef.add(client).then((documentSnapshot) =>
          print("Added client with ID: ${documentSnapshot.id}"));
    } catch (e) {
      print("Error adding client: $e");
    }
  }

  Future<void> update(clientId, clientName, clientLastName, clientPhone,
      clientDocument, clientAddress) async {
    final docRef = db.collection("clients").doc(clientId);

    try {
      await docRef.update({
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

  Future<void> delete(clientId) async {
    final docRef = db.collection("clients").doc(clientId);

    try {
      await docRef.delete().then((doc) => print("Client deleted"));
    } catch (e) {
      print("Error deleting client $e");
    }
  }
}
