import '../screens/home_page.dart';
import '../screens/setttings_page.dart';
import '../screens/clients_page.dart';
import '../screens/calculator_page.dart';
import '../screens/loans_page.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int indexPage = 0;

  final List<Widget> pages = [
    HomePage(),
    const LoansPage(),
    const ClientsPage(),
    const CalculatorPage(),
    const SettingsPage()
  ];
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Prestamos App"),
        ),
        // drawer: CustomDrawer.getDrawer(context),
        body: IndexedStack(index: indexPage, children: pages),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: indexPage,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 11.0,
          unselectedFontSize: 11.0,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_work), label: "Inicio"),
            BottomNavigationBarItem(
                icon: Icon(Icons.monetization_on), label: "Prestamos"),
            BottomNavigationBarItem(
                icon: Icon(Icons.people), label: "Clientes"),
            BottomNavigationBarItem(
                icon: Icon(Icons.calculate), label: "Calcular"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Ajustes"),
          ],
          onTap: (index) {
            setState(() {
              indexPage = index;
            });
          },
        ));
  }
}
