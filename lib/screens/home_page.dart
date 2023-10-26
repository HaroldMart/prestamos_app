import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prestamos_app/models/payment.dart';
import 'package:prestamos_app/screens/auth_pages/login_page.dart';
import 'package:prestamos_app/services/client_service.dart';
import 'package:prestamos_app/services/loan_service.dart';
import 'package:prestamos_app/services/payment_service.dart';
import '../models/client.dart';
import '../models/loan.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  Future<void> signUserOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    } catch (e) {
      print("Error al cerrar sesión: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    void inventando() async {
      // instancia de firebase
      FirebaseFirestore db = FirebaseFirestore.instance;
      final service = PaymentService(db: db);
      final clientService = ClientService(db: db);

      // payment methods --------
      // final payment = Payment_(
      //   loanId: "h2zapDxq96klJVepM3yu",
      //   mount: 3000.4,
      //   date: "hoy");
      // final miop = await service.getAll("EeENXtwRfdd9ZPVURxo5", "h2zapDxq96klJVepM3yu");  // miop.forEach((element) {print(element);});
      // final miop = await service.get("EeENXtwRfdd9ZPVURxo5", "h2zapDxq96klJVepM3yu", "dh8a7z93cexWzsu8mFsk");  // print(miop.date);
      // final miop = await service.add("EeENXtwRfdd9ZPVURxo5", "h2zapDxq96klJVepM3yu", payment);
      // final miop = await service.update("EeENXtwRfdd9ZPVURxo5", "h2zapDxq96klJVepM3yu", "fKV36bx0YxSsWbIyAYoQ", 400, "mivida");
      // final miop = await service.delete("EeENXtwRfdd9ZPVURxo5", "h2zapDxq96klJVepM3yu", "PduKlwZZciy8TpqAYd4D");

      // loan methods --------
      //   final loan =  Loan(
      //   clientId: "EeENXtwRfdd9ZPVURxo5",
      //   clientName: "izael",
      //   interest: 10,
      //   date: "mivida",
      //   mount: 304566,
      //   payment: 0,
      //   monthlyPayment: 300,
      //   total: 4902,
      //   totalMonthlyPayment: 10,
      //   lateFee: 30
      // );
      // final miop = await service.getAll("EeENXtwRfdd9ZPVURxo5");  // miop.forEach((element) {print(element);});
      // final miop = await service.get("EeENXtwRfdd9ZPVURxo5", "pCYMQVG4ooBfbsgSf7Hu");  // print(miop.clientName);
      // final miop = await service.add("EeENXtwRfdd9ZPVURxo5", loan);
      // final miop = await service.update("EeENXtwRfdd9ZPVURxo5", "h2zapDxq96klJVepM3yu", "izael", 304566, 10, 400, 20, 40000, 500, "no c", 200);
      // final miop = await service.delete("EeENXtwRfdd9ZPVURxo5", "h2zapDxq96klJVepM3yu");

      // client methods --------
      //   final client = Client(
      //   name: "mvida",
      //   lastName: "suvida",
      //   document: "03094830948",
      //   address: "su calle",
      //   phone: "89504583554"
      // );
      // final clients = await clientService.getAll();
      // clients.forEach((element) {
      //   print(element);
      // });
      // final miop = await clientService.get("EeENXtwRfdd9ZPVURxo5");  // print(miop.name);
      // final miop = await clientService.update("3SMaB3U2APDv2ThFq7Ju", "izael", "oo", "09820394324", "33333", "la esquina");
      // final miop = await clientService.delete("3SMaB3U2APDv2ThFq7Ju");
    }

    ;

    inventando();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: const Color(0xFF55A06F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '70 Clientes',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              width: double.infinity,
                              child: Opacity(
                                opacity: 0.90,
                                child: Text(
                                  'Filtra entre los clientes para gestionar pagos o agregar un nuevo préstamo.',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 17, vertical: 10),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF79B48D),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'ver clientes',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(
                                    Icons.arrow_right_sharp,
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 85,
                            height: 62.50,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://s3-alpha-sig.figma.com/img/6f7f/79c7/73c58ed6c4635bfeae9113cfbd7baf07?Expires=1699228800&Signature=pZPT27R9IQSOITjwbxRHLgPLQIGiBtA5rJOX2MCSclKEeYmiD8uWEQ~Bg0vex0rPMdUvnMyMEgwRqILpkG2uaR3VTlrJESYjItSxKgnApwvKg3I~VHECOAOBHqntFdXhoQXkgOnUgE3g1zDP7Xo44LRSMwO~tI7LGjUiz-CQoluEh5BSV61Vpp1F3n-ixGWkwDNQv-HRK~jBmDXz7slgO4X05FKYCPokz0BZuoYbTlXNHemN-X-XoIgxB6oNHBRam5xJTDRVZIO7lg9IsH1Q3-5fGIUeCU0iPKUtSdZCfyspQmP5dyDPz~yr~8hrDPMNxQ0epuzs~nvTIOVyJR7zXQ__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 11),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Acciones recientes',
                            style: TextStyle(
                              color: Color(0xFF332323),
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'ver todo',
                            style: TextStyle(
                              color: Color(0xFF8C79FF),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 330,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 75,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                    width: 1, color: Color(0xFFEBEBEB)),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFF61D538),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 20,
                                              height: 20,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: const BoxDecoration(),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      const Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Nuevo prestamo',
                                            style: TextStyle(
                                              color: Color(0xFF332323),
                                              fontSize: 16,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            'Cliente Haroldy Martinez',
                                            style: TextStyle(
                                              color: Color(0xFF374957),
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  '20/10/2023',
                                  style: TextStyle(
                                    color: Color(0xFF6F6F6F),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            height: 75,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                    width: 1, color: Color(0xFFEBEBEB)),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFF09E54),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 20,
                                              height: 20,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: const BoxDecoration(),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Container(
                                        child: const Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Actualización de info',
                                              style: TextStyle(
                                                color: Color(0xFF332323),
                                                fontSize: 16,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              'Cliente Haroldy Martinez',
                                              style: TextStyle(
                                                color: Color(0xFF374957),
                                                fontSize: 12,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  '20/10/2023',
                                  style: TextStyle(
                                    color: Color(0xFF6F6F6F),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            height: 75,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                    width: 1, color: Color(0xFFEBEBEB)),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF55A06F),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 20,
                                              height: 20,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Container(
                                        child: const Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Prestamo #1234',
                                              style: TextStyle(
                                                color: Color(0xFF332323),
                                                fontSize: 16,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              'Pago recibido',
                                              style: TextStyle(
                                                color: Color(0xFF374957),
                                                fontSize: 12,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  '20/10/2023',
                                  style: TextStyle(
                                    color: Color(0xFF6F6F6F),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            height: 75,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                    width: 1, color: Color(0xFFEBEBEB)),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFF8672FF),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Container(
                                              width: 15,
                                              height: 15,
                                              clipBehavior: Clip.none,
                                              decoration: const BoxDecoration(),
                                              child: const Icon(
                                                Icons.person_add,
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Container(
                                        child: const Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Nuevo cliente',
                                              style: TextStyle(
                                                color: Color(0xFF332323),
                                                fontSize: 16,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              'Cliente Haroldy Martinez',
                                              style: TextStyle(
                                                color: Color(0xFF374957),
                                                fontSize: 12,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  '20/10/2023',
                                  style: TextStyle(
                                    color: Color(0xFF6F6F6F),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )

          // Text(
          //   "LOGGED IN AS:  ${user.email!}",
          //   style: const TextStyle(fontSize: 20),
          // ),
          ),
    );
  }
}
