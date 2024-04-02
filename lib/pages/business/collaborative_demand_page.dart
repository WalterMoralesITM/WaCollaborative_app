import 'package:flutter/material.dart';
import 'package:wa_collaborative/pages/shared/menu_drawer_page.dart';

class CollaborativeDemandPage extends StatefulWidget {
  const CollaborativeDemandPage({super.key});

  @override
  State<CollaborativeDemandPage> createState() => _CollaborativeDemandPageState();
}

class _CollaborativeDemandPageState extends State<CollaborativeDemandPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Collaborative Demand'),
      ),
      body: Center(
        child: Text('Collaborative Demand Page Content'),
      ),
      drawer: MenuDrawerPage(),
    );
  }
}