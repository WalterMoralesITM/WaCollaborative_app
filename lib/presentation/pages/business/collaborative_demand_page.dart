import 'package:flutter/material.dart';
import 'package:wa_collaborative/data/remoteData/collaborative_demand_repository.dart';
import '../../../domain/entities/collaborative_demand_grouped.dart';
import 'collaboration_page.dart';


class CollaborativeDemandPage extends StatefulWidget {
  const CollaborativeDemandPage({Key? key}) : super(key: key);

  @override
  State<CollaborativeDemandPage> createState() => _CollaborativeDemandPageState();
}

class _CollaborativeDemandPageState extends State<CollaborativeDemandPage> {
  final CollaborativeDemandRepository _repository = CollaborativeDemandRepository();

  @override
  Widget build(BuildContext context) {
    return DemandCollaborationScreen(repository: _repository);
  }
}

class DemandCollaborationScreen extends StatelessWidget {
  final CollaborativeDemandRepository repository;

  DemandCollaborationScreen({required this.repository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<CollaborativeDemandGrouped>>(
        future: repository.getCollaborativeDemand(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error al cargar los datos'),
            );
          } else if (snapshot.hasData) {
            return ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Filtrar demanda',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      const TabBar(
                        tabs: [
                          Tab(text: 'Activo'),
                          Tab(text: 'Colaborado'),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.75,
                        child: TabBarView(
                          children: [
                            DemandList(status: 'Activo', demandData: snapshot.data!),
                            DemandList(status: 'Colaborado', demandData: snapshot.data!),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Text('No hay datos disponibles'),
            );
          }
        },
      ),
    );
  }
}

class DemandList extends StatelessWidget {
  final String status;
  final List<CollaborativeDemandGrouped> demandData;

  DemandList({required this.status, required this.demandData});

  @override
  Widget build(BuildContext context) {
    final filteredData = demandData.where((demand) => demand.status.name == status).toList();

    return ListView.builder(
      shrinkWrap: true,
      itemCount: filteredData.length,
      itemBuilder: (context, index) {
        return DemandCard(
          demand: filteredData[index],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CollaborativePage(collaborativeDemandId: filteredData[index].collaborativeDemandId)),
            );
          },
        );
      },
    );
  }
}

class DemandCard extends StatelessWidget {
  final CollaborativeDemandGrouped demand;
  final VoidCallback onTap;

  DemandCard({required this.demand, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      clipBehavior: Clip.hardEdge,
      child: ListTile(
        title: Text('Cliente: ${demand.customer.name}'),
        subtitle: Text('Producto: ${demand.product.name} \nCiudad: ${demand.city.name}'),
        //trailing: Text('Estado: ${demand.status.name}'),
        onTap: onTap,
      ),
    );
  }
}
