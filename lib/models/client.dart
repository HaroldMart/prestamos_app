import 'loan.dart';

class Client {
  String name; // nombre
  String lastName; // apellido
  int phone; // numero de telefono
  int document; // cedula
  String nationality; // nacionalidad
  String direction;
  List<Loan> loans;

  Client({required this.name, required this.lastName, required this.phone ,
   required this.document, required this.nationality, 
   required this.direction, required this.loans});
}