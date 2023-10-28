import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:prestamos_app/models/client.dart';
import 'package:prestamos_app/screens/client_pages/clients_page.dart';
import 'package:prestamos_app/screens/loan_pages/loan_details_page.dart';
import 'package:prestamos_app/services/client_service.dart';
import 'package:prestamos_app/services/loan_service.dart';
import '../../models/loan.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_scrolling_fab_animated/flutter_scrolling_fab_animated.dart';

class ClientDetailsPage extends StatefulWidget {
  ClientDetailsPage({super.key});

  late Client client;

  @override
  State<ClientDetailsPage> createState() => _ClientDetailsPage();
}

class _ClientDetailsPage extends State<ClientDetailsPage>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormState> _loanFormKey = GlobalKey<FormState>();
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Loan> loans = [];
  Loan loan = Loan(
      clientId: '',
      mount: 0.0,
      monthlyPayment: 0.0,
      totalMonthlyPayment: 0.0,
      total: 0.0,
      date: '',
      isPaid: false);

  late final TabController _tabController;
  final TextEditingController _mount = TextEditingController();
  final TextEditingController _interest = TextEditingController();
  final TextEditingController _monthlyPayment = TextEditingController();
  final TextEditingController _totalMonthlyPayment = TextEditingController();

// aqui estana initstate pero como taba haciendo este trote y se eplotaba, lo puse asi porque dijo papu chatgpt
 @override
void didChangeDependencies() {
  super.didChangeDependencies();
  widget.client = ModalRoute.of(context)!.settings.arguments as Client;
  getAllLoans(widget.client.id);
  _tabController = TabController(length: 2, vsync: this);
}

  Future<void> getAllLoans(clientId) async {
    final service = LoanService(db: db);
    final List<Loan> data = await service.getAll(clientId);
    setState(() {
      loans = data;
      if (kDebugMode) {
        print(loans.toString());
      }
    });
  }

  deleteLoan(clientId, loanId) {
    final service = LoanService(db: db);
    service.delete(clientId, loanId);
  }

  deleteSelf(clientId) {
    final service = ClientService(db: db);
    service.delete(clientId);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: ScrollingFabAnimated(
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          text: const Text(
            'Añadir prestamo',
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          color: Colors.green,
          onPress: () {
            _dialogForm(context);
          },
          scrollController: _scrollController,
          animateIcon: false,
          inverted: false,
          width: 215,
          radius: 20,
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
        body: Center(
          child: Container(
            width: double.infinity,
            height: double.maxFinite,
            decoration: const BoxDecoration(color: Color(0xFF0D47A1)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 21),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 102,
                                  height: 102,
                                  decoration: const ShapeDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://s3-alpha-sig.figma.com/img/8252/dff0/74bbf2ed399496a6b6867770170d23e9?Expires=1699228800&Signature=YjMTCwC~IWAsyK~kdSSsJD2FW7VVvCS6uT0DvF2uWFBYPj27B3X5maBljoWBsRThK1JC~elGeAOldWtGurVz9eSytXTm5Ip880rAjEWVKVQFMuSH3JXqiMTGCXuZaOzqAsW8qltm85CesfuiT0uuKlbSA4RrSmcWBYEQIc73lLQ~voCJHRKWXjhpsaWU7LhuGdCmYBJJy7BzVkhqBJEYiKPs-seAdsl6zCsKLx8NhAM-XfqjblHeyXOrLrIjAV1ezqnGpb1~LdT1OEDY~tTv~r3K3G5A5-7WmlmQksB~7kiXzbaylSJ31CJFhgqHmrcyLoV8YorSp4AJqYhKD6g1gQ__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4"),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: OvalBorder(),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${widget.client.name} ${widget.client.lastName}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      '${widget.client.document}',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: 52,
                                    height: 52,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: Colors.white
                                          .withOpacity(0.05000000074505806),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(33),
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
                                          width: 24,
                                          height: 24,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(),
                                          child: const Icon(Icons.edit_outlined,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                GestureDetector(
                                  onTap: () {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  8))),
                                              title: const Text(
                                                  'Eliminar cliente'),
                                              content: const Center(
                                                child: Text(
                                                    '¿Seguro que quieres eliminar este cliente?'),
                                              ),
                                              actions: [
                                            TextButton(
                                              onPressed: () => {
                                                Navigator.pop(
                                                    context, 'Cancel'),
                                              },
                                              child: const Text('Cancelar'),
                                            ),
                                            FilledButton(
                                              style: ButtonStyle(
                                                  shape: MaterialStateProperty
                                                      .all(RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      18.0),
                                                          side: const BorderSide(
                                                              color: Colors
                                                                  .green)))),
                                              onPressed: () => {
                                                deleteSelf(widget.client.id),
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const ClientsPage())),
                                                const SnackBar(
                                                  content:
                                                      Text('Cliente eliminado'),
                                                )
                                              },
                                              child: const Text('Eliminar'),
                                            ),
                                          ]),
                                    );
                                  },
                                  child: Container(
                                    width: 52,
                                    height: 52,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: Colors.white
                                          .withOpacity(0.05000000074505806),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(33),
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
                                          width: 24,
                                          height: 24,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(),
                                          child: const Icon(
                                            Icons.delete_outline,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 40),
                    clipBehavior: Clip.antiAlias,
                    decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // AQUI ESTA EL TAPBAR
                          child: TabBar(
                              controller: _tabController,
                              labelStyle:
                                  const TextStyle(fontWeight: FontWeight.w800),
                              labelColor:
                                  const Color.fromARGB(255, 91, 76, 175),
                              unselectedLabelStyle: const TextStyle(
                                  fontWeight: FontWeight.normal),
                              unselectedLabelColor:
                                  const Color.fromARGB(255, 168, 168, 168),
                              indicator: const BoxDecoration(
                                  color: Colors.transparent),
                              tabs: const [
                                Tab(text: 'Información'),
                                Tab(text: 'Prestamos')
                              ]),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 300,
                          child: Expanded(
                            child: TabBarView(
                                controller: _tabController,
                                children: [
                                  SingleChildScrollView(
                                    child: SizedBox(
                                      // PARTE 1 del TabBar
                                      width: 340,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: const Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Información del cliente',
                                                  style: TextStyle(
                                                    color: Color(0xFF1E293B),
                                                    fontSize: 18,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          Container(
                                            width: double.infinity,
                                            decoration: const BoxDecoration(),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Nombre',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF73787E),
                                                        fontSize: 14,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      'Cristian Tejeda',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF1E293B),
                                                        fontSize: 16,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 30),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'Cedula',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF73787E),
                                                        fontSize: 14,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      '${widget.client.document}',
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFF1E293B),
                                                        fontSize: 16,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 30),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'Telefono',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF73787E),
                                                        fontSize: 14,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      '${widget.client.phone}',
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFF1E293B),
                                                        fontSize: 16,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 30),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'Direccion',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF73787E),
                                                        fontSize: 14,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    SizedBox(
                                                      width: double.infinity,
                                                      child: Text(
                                                        '${widget.client.address}',
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xFF1E293B),
                                                          fontSize: 16,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: SizedBox(
                                      width: 340,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: const Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Prestamos',
                                                  style: TextStyle(
                                                    color: Color(0xFF1E293B),
                                                    fontSize: 18,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          Container(
                                            width: double.infinity,
                                            clipBehavior: Clip.none,
                                            decoration: const BoxDecoration(),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // AQUI LOS PRESTAMOS
                                                const SizedBox(height: 10),
                                                loans.isEmpty
                                                    ? const Center(
                                                        child: Text(
                                                            'Aún no le has dado un prestamo a este cliente.',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      59,
                                                                      114,
                                                                      114,
                                                                      114),
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            )),
                                                      )
                                                    : Container(
                                                        width: double.infinity,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 20),
                                                        decoration:
                                                            const BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                                width: 1,
                                                                color: Color(
                                                                    0xFFEBEBEB)),
                                                          ),
                                                        ),
                                                        child: ListView.builder(
                                                            shrinkWrap: true,
                                                            itemCount:
                                                                loans.length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return Container(
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pushNamed(
                                                                            '/loan_details',
                                                                            arguments: {
                                                                          'clientId': widget
                                                                              .client
                                                                              .id,
                                                                          'loan':
                                                                              loans[index],
                                                                        });
                                                                  },
                                                                  onLongPress:
                                                                      () {
                                                                    _buildBottomSheet(
                                                                        index);
                                                                  },
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            loans[index].date,
                                                                            style:
                                                                                const TextStyle(
                                                                              color: Color(0xFF73787E),
                                                                              fontSize: 14,
                                                                              fontFamily: 'Poppins',
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 3),
                                                                          Text(
                                                                            loans[index].mount.toString(),
                                                                            style:
                                                                                const TextStyle(
                                                                              color: Color(0xFF1E293B),
                                                                              fontSize: 18,
                                                                              fontFamily: 'Poppins',
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                          width:
                                                                              30),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          _buildBottomSheet(
                                                                              index);
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              10),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Container(
                                                                                width: 24,
                                                                                height: 24,
                                                                                clipBehavior: Clip.antiAlias,
                                                                                decoration: const BoxDecoration(),
                                                                                child: const Icon(Icons.more_vert),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                              // Container(
                                                              //     child: ListView.builder(
                                                              //       shrinkWrap: true,
                                                              //       itemCount: loans.length,
                                                              //       itemBuilder: (BuildContext context, int index) {
                                                              //         return Container(
                                                              //             width: 350,
                                                              //             padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                                              //             margin: const EdgeInsets.symmetric( vertical: 8, horizontal: 0),
                                                              //             clipBehavior: Clip .antiAlias,
                                                              //             decoration: BoxDecoration(
                                                              //               color: Colors.white,
                                                              //               borderRadius: BorderRadius.circular(19),
                                                              //               boxShadow: const [
                                                              //                 BoxShadow(
                                                              //                   color: Color(0xFFE5E5E5),
                                                              //                   blurRadius: 7,
                                                              //                   offset:
                                                              //                       Offset(
                                                              //                           0,
                                                              //                           3),
                                                              //                   spreadRadius:
                                                              //                       1,
                                                              //                 )
                                                              //               ],
                                                              //             ),
                                                              //             child: ListTile(
                                                              //               leading: Container(
                                                              //                   width: 44,
                                                              //                   height: 44,
                                                              //                   clipBehavior: Clip.antiAlias,
                                                              //                   decoration: ShapeDecoration(
                                                              //                     color: const Color(
                                                              //                         0xFF41E085),
                                                              //                     shape:
                                                              //                         RoundedRectangleBorder(
                                                              //                       borderRadius:
                                                              //                           BorderRadius.circular(15),
                                                              //                     ),
                                                              //                   )),
                                                              //               title: Text(loans[
                                                              //                       index]
                                                              //                   .mount
                                                              //                   .toString()),
                                                              //               subtitle: Text(
                                                              //                   loans[index]
                                                              //                       .date),
                                                              //               trailing:
                                                              //                   IconButton(
                                                              //                 icon: const Icon(
                                                              //                     Icons
                                                              //                         .more_vert),
                                                              //                 onPressed:
                                                              //                     () {
                                                              //                   _buildBottomSheet(
                                                              //                       index);
                                                              //                 },
                                                              //               ),
                                                              //               onTap: () {
                                                              //                 Navigator.of(
                                                              //                         context)
                                                              //                     .pushNamed(
                                                              //                         '/loan_details',
                                                              //                         arguments: {
                                                              //                       'clientId': widget
                                                              //                           .client
                                                              //                           .id,
                                                              //                       'loan':
                                                              //                           loans[index],
                                                              //                     });
                                                              //               },
                                                              //               onLongPress:
                                                              //                   () {
                                                              //                 _buildBottomSheet(
                                                              //                     index);
                                                              //               },
                                                              //             ));
                                                              //       },
                                                              //     ),
                                                              //   )
                                                            }),
                                                      )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )

        //             loans.isEmpty?
        //               const Center(
        //                 child: Text('Aún no le has dado un prestamo a este cliente.',
        //                   textAlign: TextAlign.center,
        //                   style: TextStyle(
        //                     color: Color.fromARGB(59, 114, 114, 114),
        //                     fontSize: 18,
        //                     fontWeight: FontWeight.w600,
        //                     height: 0,
        //                   )
        //                 ),
        //               ) :Container(
        //               child: ListView.builder(
        //                   shrinkWrap: true,
        //                   itemCount: loans.length,
        //                   itemBuilder: (BuildContext context, int index) {
        //                     return Container(
        //                       width: 350,
        //                       padding: const EdgeInsets.symmetric(
        //                         vertical: 5,
        //                         horizontal: 5,
        //                       ),
        //                       margin: const EdgeInsets.symmetric(
        //                         vertical: 8,
        //                         horizontal: 0,
        //                       ),
        //                       clipBehavior: Clip.antiAlias,
        //                       decoration: BoxDecoration(
        //                         color: Colors.white,
        //                         borderRadius: BorderRadius.circular(19),
        //                         boxShadow: const [
        //                           BoxShadow(
        //                             color: Color(0xFFE5E5E5),
        //                             blurRadius: 7,
        //                             offset: Offset(0, 3),
        //                             spreadRadius: 1,
        //                           )
        //                         ],
        //                       ),
        //                       child: ListTile(
        //                         leading: Container(
        //                             width: 44,
        //                             height: 44,
        //                             clipBehavior: Clip.antiAlias,
        //                             decoration: ShapeDecoration(
        //                                 color: const Color(0xFF41E085),
        //                                 shape: RoundedRectangleBorder(
        //                                     borderRadius: BorderRadius.circular(15),
        //                                 ),
        //                             )
        //                         ),
        //                         title: Text(loans[index].mount.toString()),
        //                         subtitle: Text(loans[index].date),
        //                         trailing: IconButton(
        //                           icon: const Icon(Icons.more_vert),
        //                           onPressed: () {
        //                             _buildBottomSheet(index);
        //                           },
        //                         ),
        //                         onTap: () {
        //                            Navigator.of(context).pushNamed('/loan_details', arguments: {
        //                               'clientId':widget.client.id,
        //                               'loan': loans[index],
        //                            });
        //                         },
        //                         onLongPress: () {
        //                           _buildBottomSheet(index);
        //                         },
        //                       )
        //                     );
        //                   },
        //                 ),
        //             )
        //         ]),
        //       ),
        //     ],
        //   ),
        // )
        );
  }

  Future<void> _dialogForm(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: const Text('Añadir prestamo'),
            content: Form(
                key: _loanFormKey,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        controller: _mount,
                        decoration: InputDecoration(
                          labelText: 'Monto',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'No dejes este campo vacio';
                          }
                          return null;
                        },
                        onSaved: (velue) {
                          setState(() {
                            loan.mount = double.parse(_mount.text);
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        controller: _interest,
                        decoration: InputDecoration(
                          labelText: 'Interés',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'No dejes este campo vacio';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            loan.interest = double.parse(_interest.text);
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        controller: _monthlyPayment,
                        decoration: InputDecoration(
                          labelText: 'Cuota',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'No dejes este campo vacio';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            loan.monthlyPayment =
                                double.parse(_monthlyPayment.text);
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        controller: _totalMonthlyPayment,
                        decoration: InputDecoration(
                          labelText: 'Cuota totales',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'No dejes este campo vacio';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            loan.totalMonthlyPayment =
                                double.parse(_totalMonthlyPayment.text);
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

                                    String clientId = '${widget.client.id}';
                                    var date = DateTime.now();
                                    loan.date =
                                        '${date.day} de ${date.month}, ${date.year}';

                                    final loanService = LoanService(db: db);
                                    loanService.add(clientId, loan);

                                    setState(() {
                                      getAllLoans(clientId);
                                    });

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Prestamo agregado exitosamente.')),
                                    );
                                    Navigator.of(context).pop();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Error al agregar pago.')),
                                    );
                                  }
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

  Future<dynamic> _buildBottomSheet(loanIndex) => showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 190,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: ListView(
                  children: [
                    ListTile(
                      leading: const Icon(IconlyBold.edit),
                      title: const Text('Editar'),
                      subtitle: const Text('Editar este prestamo'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(IconlyBold.delete),
                      title: const Text('Borrar'),
                      subtitle: const Text('Eliminar este prestamo'),
                      onTap: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              title: const Text('Eliminar prestamo'),
                              content: const Text(
                                  '¿Seguro que quieres eliminar prestamo?'),
                              actions: [
                                TextButton(
                                  onPressed: () => {
                                    Navigator.pop(context, 'Cancel'),
                                  },
                                  child: const Text('Cancelar'),
                                ),
                                FilledButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              side: const BorderSide(
                                                  color: Colors.green)))),
                                  onPressed: () => {
                                    deleteLoan(
                                        widget.client.id, loans[loanIndex].id),
                                    getAllLoans(widget.client.id),
                                    Navigator.pop(context, 'Eliminar'),
                                    const SnackBar(
                                      content: Text('Prestamo eliminado'),
                                    )
                                  },
                                  child: const Text('Eliminar'),
                                ),
                              ]),
                        );
                      },
                    )
                  ],
                )),
          );
        },
      );
}
