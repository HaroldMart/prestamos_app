import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/client.dart';

// FirebaseFirestore db = FirebaseFirestore.instance;

class ClientService {
  FirebaseFirestore db;

  ClientService({
    required this.db
  });

  Future<List> getAll() async {
    List clients = [];

    final dbRef = db.collection("clients");

    dbRef.get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          clients.add(docSnapshot.data());
        }
      },
      onError: (e) => print("Error getting clients: $e"),
    );

    return clients;
  }

  Future<Client> getClient(clientId) async {
    final docRef = db.collection("clients").doc(clientId);

    await docRef.get().then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;

      final client = Client(
          name: data["name"],
          lastName: data["lastname"],
          phone: data["phone"],
          document: data["document"],
          direction: data["direction"]);

      return client;
    }, onError: (e) => print("Error getting client document: $e"));

    return Client(
        name: "", lastName: "", phone: "", document: "", direction: "");
  }

  Future<void> add(client) async {
    final dbRef = db.collection("clients").withConverter(
          fromFirestore: Client.fromFirestore,
          toFirestore: (Client client, options) => client.toFirestore(),
        );

    await dbRef.add(client).then((documentSnapshot) => {
          documentSnapshot.collection("clients").add(client),
          print("Added client with ID: ${documentSnapshot.id}")
        });
  }

  Future<void> update(clientId, clientName, clientLastName, clientPhone,
      clientDocument, clientDirection) async {
    final docRef = db.collection("clients").doc(clientId);

    await docRef.update({
      "name": clientName,
      "lastName": clientLastName,
      "phone": clientPhone,
      "document": clientDocument,
      "direction": clientDirection
    }).then((value) => print("DocumentSnapshot successfully updated!"),
        onError: (e) => print("Error updating client document $e"));
  }

  Future<void> delete(clientId) async {
    final docRef = db.collection("clients").doc(clientId);

    await docRef.delete().then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
  }
}
