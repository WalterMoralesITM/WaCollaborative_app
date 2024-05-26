import 'package:flutter/material.dart';
import 'package:wa_collaborative/data/remoteData/collaborative_demand_repository.dart';
import '../../../domain/entities/collaborative_demand_grouped.dart';
import '../graphics/bar_chart_sample_2.dart';
import 'collaboration_page.dart';

class CollaborativeDemandHistoryPage extends StatefulWidget {
  const CollaborativeDemandHistoryPage({Key? key}) : super(key: key);

  @override
  State<CollaborativeDemandHistoryPage> createState() => _CollaborativeDemandHistoryPage();
}

class _CollaborativeDemandHistoryPage extends State<CollaborativeDemandHistoryPage> {
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
        future: repository.getCollaborativeDemandHistory(),
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
            return DemandList(demandData: snapshot.data!);
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
  final List<CollaborativeDemandGrouped> demandData;

  DemandList({required this.demandData});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: demandData.length,
      itemBuilder: (context, index) {
        return DemandCard(
          demand: demandData[index],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BarChartSample2(collaborativeDemandId: demandData[index].collaborativeDemandId)),
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
        subtitle: Text('Producto: ${demand.product.name} \nCiudad: ${demand.city.name} \nPeriodo: ${demand.initialPeriod.toString().substring(0,4)}/${demand.initialPeriod.toString().substring(4,6)}  - ${demand.finalPeriod.toString().substring(0,4)}/${demand.finalPeriod.toString().substring(4,6)}'),

        //trailing: Text('Estado: ${demand.status.name}'),
        onTap: onTap,
      ),
    );
  }
}
