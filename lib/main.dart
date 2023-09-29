// import 'package:flutter/material.dart';
// import 'screens/clients.dart';
// import 'screens/home.dart';
// import 'screens/loans.dart';
// import 'screens/calculator.dart';
// import 'screens/setttings.dart';
// import 'screens/auth/login_page.dart';
// import 'package:firebase_core/firebase_core.dart';
// // import 'widgets/side_menu.dart';

// Future<void> main() async {
// WidgetsFlutterBinding.ensureInitialized();
// await Firebase.initializeApp();

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Prestamos App',
//         theme: ThemeData(
//           brightness: Brightness.dark,
//           primaryColor: const Color.fromARGB(255, 31, 109, 155),
//           ),
//         debugShowCheckedModeBanner: false,
//         home: const Home());
//   }
// }

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
   
//   int indexPage = 0;
  
//   final List<Widget> pages = [
//      const HomePage(),
//      const Loans(),
//     const Clients(),
//      const Calculator(),
//      const Settings()
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Prestamos App"),
//       ),
//       // drawer: CustomDrawer.getDrawer(context),
//       body: IndexedStack(
//         index: indexPage,
//         children: pages
//         ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: indexPage, 
//         type: BottomNavigationBarType.fixed,
//         selectedFontSize: 11.0,
//         unselectedFontSize: 11.0,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home_work), label: "Inicio"),
//           BottomNavigationBarItem(icon: Icon(Icons.monetization_on), label: "Prestamos"),
//           BottomNavigationBarItem(icon: Icon(Icons.people), label: "Clientes"),
//           BottomNavigationBarItem(icon: Icon(Icons.calculate), label: "Calcular"),
//           BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Ajustes"),
//         ],
//         onTap: (index) {
//           setState(() {
//              indexPage = index;
//           });
//         },
        
//     )
//     );
//   }
// }
