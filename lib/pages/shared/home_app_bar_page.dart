import 'package:flutter/material.dart';
import '../authentication/profile_page.dart';
import '../business/clients_page.dart';
import '../business/collaborative_demand_page.dart';
import '../graphics/bar_chart_sample_2.dart';

class HomePageTabsPage extends StatefulWidget {
  final int initialTabIndex; // Nuevo: Índice del tab inicial

  const HomePageTabsPage({Key? key, this.initialTabIndex = 0}) : super(key: key);

  @override
  State<HomePageTabsPage> createState() => _HomePageTabsPageState();
}

class _HomePageTabsPageState extends State<HomePageTabsPage> {
  final List<Widget> _pages = [
    CollaborativeDemandPage(),
    ClientsPage(),
    BarChartSample2(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: _pages.length,
        initialIndex: widget.initialTabIndex, // Nuevo: Índice inicial
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.folder_shared)),
                Tab(icon: Icon(Icons.supervisor_account)),
                Tab(icon: Icon(Icons.history)),
                Tab(icon: Icon(Icons.person)),
              ],
            ),
            title: const Text('Colaboración de la demanda'),
          ),
          body: TabBarView(
            children: _pages,
          ),
        ),
      ),
    );
  }
}

void navigateToPage(BuildContext context, int pageIndex) {
  DefaultTabController.of(context)?.animateTo(pageIndex);
}
