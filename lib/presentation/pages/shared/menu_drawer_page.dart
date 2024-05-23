import 'package:flutter/material.dart';

import '../business/clients_page.dart';
import '../business/collaborative_demand_page.dart';
import '../business/history_page.dart';

class MenuDrawerPage extends StatefulWidget {
  const MenuDrawerPage({super.key});

  @override
  State<MenuDrawerPage> createState() => _MenuDrawerPageState();
}

class _MenuDrawerPageState extends State<MenuDrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Menu'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Demand Plan'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CollaborativeDemandPage()),
              );
            },
          ),
          ListTile(
            title: Text('History'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoryPage()),
              );
            },
          ),
          ListTile(
            title: Text('Clients'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClientsPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}