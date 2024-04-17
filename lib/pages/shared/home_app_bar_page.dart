import 'package:flutter/material.dart';
import '../authentication/profile_page.dart';
import '../business/clients_page.dart';
import '../business/collaborative_demand_page.dart';
import '../graphics/line_chart.dart';

class HomePageTabsPage extends StatefulWidget {
  const HomePageTabsPage({Key? key}) : super(key: key);

  @override
  State<HomePageTabsPage> createState() => _HomePageTabsPageState();
}

class _HomePageTabsPageState extends State<HomePageTabsPage> {
  final List<Widget> _pages = [
    CollaborativeDemandPage(),
    ClientsPage(),
    LineChartSample1(),//HistoryPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
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
  DefaultTabController.of(context).animateTo(pageIndex);
}
