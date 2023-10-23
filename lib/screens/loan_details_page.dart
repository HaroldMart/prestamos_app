import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prestamos_app/models/client.dart';
import 'package:prestamos_app/models/payment.dart';
import 'package:prestamos_app/services/loan_service.dart';
import 'package:prestamos_app/services/payment_service.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../models/loan.dart';
import '../models/payment.dart';
import 'package:flutter_scrolling_fab_animated/flutter_scrolling_fab_animated.dart';

class LoanDetailsPage extends StatefulWidget {

  const LoanDetailsPage(this.clientId, this.loan, {super.key});
  final String? clientId;
  final Loan loan;

  @override
  State<LoanDetailsPage> createState() => _LoanDetailsPage();
}

class _LoanDetailsPage extends State<LoanDetailsPage> {

  final ScrollController _scrollController = new ScrollController();
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Payment_> payments = [];
  late Payment_ loan;
  final GlobalKey<FormState> _loanFormKey = GlobalKey<FormState>();
  TextEditingController _mountController = TextEditingController();
  late Payment_ payment = Payment_(
    loanId: '',
    mount: 0.0,
    date: '0 enero, 0000'
  );

  @override
  void initState() {
    super.initState();
    getAllPayments(widget.clientId, widget.loan.id);
  }

  Future<void> getAllPayments(clientId, loanId) async {
    final service = PaymentService(db: db);
    final List<Payment_> data = await service.getAll(clientId, loanId);
    setState(() {
      payments = data;
      print(payments.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.loan.mount.toString()),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            color: Colors.black,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        floatingActionButton: ScrollingFabAnimated(
          icon: const Icon(Icons.add, color: Colors.white,),
          text: const Text('Añadir pago', style: TextStyle(color: Colors.white ,fontSize: 16.0),),
          color: Colors.green,
          onPress: () {
            _dialogForm(context);
          },
          scrollController: _scrollController,
          animateIcon: false,
          inverted: false,
          width: 170,
          radius: 20,
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
              children: [
                SizedBox(
                  width: 312,
                  child: Text("${widget.loan.mount}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Color(0xFF3EAD2C),
                          fontSize: 36,
                          fontWeight: FontWeight.w600,
                          height: 0,
                      ),
                  ),
                ),
                const SizedBox(height: 12,),
                Container(
                  width: 350,
                  height: 258,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(19),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFFE5E5E5),
                        blurRadius: 7,
                        offset: Offset(0, 3),
                        spreadRadius: 1,
                      )
                    ]), 
                  child: GridView.count(
                    primary: false,
                    crossAxisCount: 2,
                    mainAxisSpacing: 0.0,
                    crossAxisSpacing: 0.0,
                    childAspectRatio: 1.0,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('TOTAL PRESTAMO:',
                          style: TextStyle(
                            color: Color(0xFF90A4AE),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 0,
                          )),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: double.infinity,
                            child: Text('${widget.loan.mount}',
                            style: const TextStyle(
                              color: Color(0xFF2B3841),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            )),
                          ),
                        ],
                      ),
                      const Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text('TOTAL PAGADO:',
                          style: TextStyle(
                            color: Color(0xFF90A4AE),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 0,
                          )),
                           SizedBox(height: 5),
                          SizedBox(
                            width: double.infinity,
                            child: Text('Aun no disponible',
                            style: TextStyle(
                              color: Color(0xFF2B3841),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            )),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('TOTAL PENDIENTE:',
                          style: TextStyle(
                            color: Color(0xFF90A4AE),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 0,
                          )),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: double.infinity,
                            child: Text('${widget.loan.totalMonthlyPayment}',
                            style: const TextStyle(
                              color: Color(0xFF2B3841),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            )),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('INTERES:',
                          style: TextStyle(
                            color: Color(0xFF90A4AE),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 0,
                          )),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: double.infinity,
                            child: Text('${widget.loan.interest}',
                            style: const TextStyle(
                              color: Color(0xFF2B3841),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            )),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('FECHA DE CREACIÓN:',
                          style: TextStyle(
                            color: Color(0xFF90A4AE),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 0,
                          )),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: double.infinity,
                            child: Text('${widget.loan.date}',
                            style: const TextStyle(
                              color: Color(0xFF2B3841),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            )),
                          ),
                        ],
                      ), 
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 13),
                  child: Text('Historial de pagos',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    )
                  ),
                ),
                payments.isEmpty
                ? const Center(
                  child: Text('No se han registrado pagos',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(59, 114, 114, 114),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    )
                  ))
                : ListView.builder(
                  shrinkWrap: true,
                  itemCount: payments.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 5,
                      ),
                      margin: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 0,
                      ),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(19),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFFE5E5E5),
                            blurRadius: 7,
                            offset: Offset(0, 3),
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      child: ListTile(
                        title: Text(payments[index].mount.toString(),
                           style: const TextStyle(
                            color: Color(0xFF3EAD2C),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ), 
                        ),
                        subtitle: Text("Fecha: ${payments[index].date}",
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ), 
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
        ));
  }

  Future<void> _dialogForm(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: const Text('Añadir pago'),
            content: Form(
                key: _loanFormKey,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _mountController,
                        decoration: InputDecoration(
                          labelText: 'Monto',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'No dejes este campo vacio';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            payment.mount = double.parse(_mountController.text);
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
                                  if (_loanFormKey.currentState!.validate()) {
                                    _loanFormKey.currentState!.save();

                                    var date = DateTime.now();
                                    payment.date = '${date.day} ${date.month} ${date.year}';
                                    String clientId = '${widget.clientId}';
                                    String loanId = '${widget.loan.id}';
                                    final paymentService = PaymentService(db: db);
                                    paymentService.add(clientId, loanId, payment);

                                    setState(() {
                                      getAllPayments(clientId, loanId);
                                    });
                                
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Pago registrado exitosamente.')
                                      ),
                                    );
                                    Navigator.of(context).pop();
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Error al registrar pago.')
                                    ),
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
