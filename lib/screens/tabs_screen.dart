import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prestamos_app/services/client_service.dart';
import 'home_page.dart';
import 'setttings_page.dart';
import 'client_pages/clients_page.dart';
import 'search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int indexPage = 0;

  final List<Widget> pages = [
    HomePage(),
    const ClientsPage(),
    const SearchPage(),
    const SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            "Prestamos App",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          automaticallyImplyLeading: true,
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
                icon: Icon(IconlyBold.home), label: "Inicio"),
            BottomNavigationBarItem(
                icon: Icon(IconlyBold.user3), label: "Clientes"),
            BottomNavigationBarItem(
                icon: Icon(IconlyBold.search), label: "Buscar"),
            BottomNavigationBarItem(
                icon: Icon(IconlyBold.setting), label: "Ajustes"),
          ],
          onTap: (index) {
            setState(() {
              indexPage = index;
            });
          },
        ));
  }
}
