import 'package:flutter/material.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class CustomDrawer {
  static int selectedDrawerIndex = 1;

  static final _drawerItems = [
    DrawerItem("Mi perfil", Icons.person),
    DrawerItem("Lista de clientes", Icons.people),
    DrawerItem("Lista de prestamos", Icons.money),
    DrawerItem("Caculadora", Icons.calculate),
    DrawerItem("Ajustes", Icons.settings)
  ];

  static _onTapDrawer(int itemPos, BuildContext context) {
    Navigator.pop(context);
    selectedDrawerIndex = itemPos;
  }

  static Widget getDrawer(BuildContext context) {
    List<Widget> drawerOptions = [];

    for (var i = 0; i < _drawerItems.length; i++) {
      var d = _drawerItems[i];
      drawerOptions.add(ListTile(
        leading: Icon(d.icon),
        title: Text(d.title),
        selected: i == selectedDrawerIndex,
        onTap: () => _onTapDrawer(i, context),
      ));
    }

    // menu lateral
    return Drawer(
      child: Column(
        children: <Widget>[
          const UserAccountsDrawerHeader(
              accountName: Text("Papa de kristiam"),
              accountEmail: Text("papideKris@gmail.com")),
          Column(children: drawerOptions)
        ],
      ),
    );
  }
}
