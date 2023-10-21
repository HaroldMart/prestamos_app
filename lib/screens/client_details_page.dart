import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prestamos_app/models/client.dart';
import 'package:prestamos_app/screens/loan_details_page.dart';
import 'package:prestamos_app/services/loan_service.dart';
import '../models/loan.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class ClientDetailsPage extends StatefulWidget {
  const ClientDetailsPage(this.client, {super.key});

  final Client client;

  @override
  State<ClientDetailsPage> createState() => _ClientDetailsPage();
}

class _ClientDetailsPage extends State<ClientDetailsPage>  with TickerProviderStateMixin {

  final GlobalKey<FormState> _loanFormKey = GlobalKey<FormState>();
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Loan> loans = [];
  late Loan loan;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    getAllLoans(widget.client.id);
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> getAllLoans(clientId) async {
    final service = LoanService(db: db);
    final List<Loan> data = await service.getAll(clientId);
    setState(() {
      loans = data;
      print(loans.toString());
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {}
      ),
      appBar: AppBar(
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
        backgroundColor: const Color.fromARGB(255, 244, 244, 244),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 332,
                height: 220,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 106,
                      height: 107,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        image: const DecorationImage(
                          image: NetworkImage("https://via.placeholder.com/106x107"),
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(27),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.client.name} ${widget.client.lastName}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF2B3841),
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {}, 
                          icon: const Icon(IconlyLight.edit)
                        ),
                        IconButton(
                          onPressed: () {}, 
                          icon: const Icon(IconlyLight.delete)
                          )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: 132,
                height: 2,
                decoration: const BoxDecoration(color: Color(0xFFD9D9D9)),
              ),
              Container(
                child: TabBar(
                  controller: _tabController,
                  labelStyle: const TextStyle(fontWeight: FontWeight.w800),
                  labelColor: Colors.green,
                  unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
                  unselectedLabelColor: const Color.fromARGB(255, 168, 168, 168),
                  indicator: const BoxDecoration(color: Colors.transparent),
                  tabs: const [
                    Tab(text: 'Información'),
                    Tab(text: 'Prestamos')
                ]),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                width: double.maxFinite,
                height: 450,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(19),
                        boxShadow: const [
                          // BoxShadow(
                          //   color: Color.fromARGB(255, 135, 135, 135),
                          //   blurRadius: 7,
                          //   offset: Offset(0, 3),
                          //   spreadRadius: 1,
                          // )
                      ]),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    const Text('Nombre',style: TextStyle(
                                      color: Color(0xFF90A4AE),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),),
                                    const SizedBox(height: 5),
                                    Text('${widget.client.name}',style: const TextStyle(
                                      color: Color(0xFF2B3841),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),),
                                ],
                            ),
                          ),
                          const SizedBox(height: 25,),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    const Text('Apellido',style: TextStyle(
                                      color: Color(0xFF90A4AE),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),),
                                    const SizedBox(height: 5),
                                    Text('${widget.client.lastName}',style: const TextStyle(
                                      color: Color(0xFF2B3841),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),),
                                ],
                            ),
                          ),
                          const SizedBox(height: 25),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    const Text('Cedula',style: TextStyle(
                                      color: Color(0xFF90A4AE),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),),
                                    const SizedBox(height: 5),
                                    Text('${widget.client.document}' ,style: const TextStyle(
                                      color: Color(0xFF2B3841),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),),
                                ],
                            ),
                          ),
                          const SizedBox(height: 25),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    const Text('Cedula',style: TextStyle(
                                      color: Color(0xFF90A4AE),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),),
                                    const SizedBox(height: 5),
                                    Text('${widget.client.address}' ,style: const TextStyle(
                                      color: Color(0xFF2B3841),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),),
                                ],
                            ),
                          ),
                          const SizedBox(height: 25,),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    const Text('Cedula',style: TextStyle(
                                      color: Color(0xFF90A4AE),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),),
                                    const SizedBox(height: 5),
                                    Text('${widget.client.phone}' ,style: const TextStyle(
                                      color: Color(0xFF2B3841),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),),
                                ],
                            ),
                          ),
                      ],),
                    ),
                    loans.isEmpty? 
                      const Center(
                        child: Text('Aún no le has dado un prestamo a este cliente.'),
                      ) :Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: loans.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              width: 350,
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 5,
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
                                leading: Container(
                                    width: 44,
                                    height: 44,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                        color: const Color(0xFF41E085),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15),
                                        ),
                                    )
                                ),
                                title: Text(loans[index].total.toString()),
                                subtitle: Text(loans[index].date),
                                trailing: const Icon(IconlyLight.arrowRight2),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => LoanDetailsPage(widget.client.id, loans[index])));
                                },
                                onLongPress: () {},
                              )
                            );
                          },
                        ),
                    )
                ]),
              ),
            ],
          ),
        ));
  }
}
