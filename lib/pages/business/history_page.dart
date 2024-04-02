import 'package:flutter/material.dart';
import 'package:wa_collaborative/pages/shared/menu_drawer_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: Center(
        child: Text('History Page Content'),
      ),
      drawer: MenuDrawerPage(),
    );
  }
}