import 'package:cloud_firestore/cloud_firestore.dart';
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
  ClientDetailsPage( {super.key});

  late Client client;

  @override
  State<ClientDetailsPage> createState() => _ClientDetailsPage();
  
}

class _ClientDetailsPage extends State<ClientDetailsPage>  with TickerProviderStateMixin {

  final ScrollController _scrollController = new ScrollController();
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
    isPaid: false
  );

  late final TabController _tabController;
  TextEditingController _mount = TextEditingController();
  TextEditingController _interest = TextEditingController();
  TextEditingController _monthlyPayment = TextEditingController();
  TextEditingController _totalMonthlyPayment = TextEditingController();

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
      print(loans.toString());
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
        icon: const Icon(Icons.add, color: Colors.white,),
        text: const Text('Añadir prestamo', style: TextStyle(color: Colors.white ,fontSize: 16.0),),
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
        body: SingleChildScrollView(
          controller: _scrollController,
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
                          icon: const Icon(IconlyLight.edit),
                          onPressed: () {}, 
                        ),
                        IconButton(
                          icon: const Icon(IconlyLight.delete),
                          onPressed: () {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20))),
                                  title: const Text('Eliminar cliente'),
                                  content: const Text(
                                      '¿Seguro que quieres eliminar este cliente?'),
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
                                        deleteSelf(widget.client.id),
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ClientsPage())),
                                        const SnackBar(
                                          content: Text('Cliente eliminado'),
                                        )
                                      },
                                      child: const Text('Eliminar'),
                                    ),
                                  ]),
                            );
                          }, 
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
                                    Text('${widget.client.document}',
                                      style: const TextStyle(
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
                        child: Text('Aún no le has dado un prestamo a este cliente.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(59, 114, 114, 114),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            height: 0,
                          )
                        ),
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
                                title: Text(loans[index].mount.toString()),
                                subtitle: Text(loans[index].date),
                                trailing: IconButton(
                                  icon: const Icon(Icons.more_vert),
                                  onPressed: () {
                                    _buildBottomSheet(index);
                                  },
                                ),
                                onTap: () {
                                   Navigator.of(context).pushNamed('/loan_details', arguments: {
                                      'clientId':widget.client.id,
                                      'loan': loans[index],
                                   });
                                },
                                onLongPress: () {
                                  _buildBottomSheet(index);
                                },
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

  Future<void> _dialogForm(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: const Text('Añadir prestamo'),
            content: Form(
                key: _loanFormKey,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        controller: _mount,
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
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
                            loan.monthlyPayment = double.parse(_monthlyPayment.text);
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
                            loan.totalMonthlyPayment = double.parse(_totalMonthlyPayment.text);
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
                                    loan.date = '${date.day} de ${date.month}, ${date.year}';

                                    final loanService = LoanService(db: db);
                                    loanService.add(clientId, loan);

                                    setState(() {
                                      getAllLoans(clientId);
                                    });
                                
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Prestamo agregado exitosamente.')
                                      ),
                                    );
                                    Navigator.of(context).pop();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Error al agregar pago.')
                                    ),
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
                                    deleteLoan(widget.client.id ,loans[loanIndex].id),
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
