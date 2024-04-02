import 'package:flutter/material.dart';
import 'package:wa_collaborative/pages/shared/menu_drawer_page.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({super.key});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clients'),
      ),
      body: Center(
        child: Text('Clients Page Content'),
      ),
      drawer: MenuDrawerPage(),
    );
  }
}