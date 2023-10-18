import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prestamos_app/services/client_service.dart';
import '../screens/home_page.dart';
import '../screens/setttings_page.dart';
import '../screens/clients_page.dart';
import '../screens/calculator_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int indexPage = 0;

  final List<Widget> pages = [
    HomePage(),
    const ClientsPage(),
    const CalculatorPage(),
    const SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("Prestamos App", style: TextStyle(color: Colors.black),),
          elevation: 0,
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
              icon: Icon(IconlyLight.home),
              activeIcon: Icon(IconlyBold.home), 
              label: "Inicio"
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.user3), 
              activeIcon: Icon(IconlyBold.user3),
              label: "Clientes"
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.filter), 
              activeIcon: Icon(IconlyBold.filter),
              label: "Calcular"
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.profile), 
              activeIcon: Icon(IconlyBold.profile),
              label: "Ajustes"
            ),
          ],
          onTap: (index) {
            setState(() {
              indexPage = index;
            });
          },
        ));
  }
}
