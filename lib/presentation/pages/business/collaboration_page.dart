import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../data/remoteData/collaborative_demand_repository.dart';
import '../../../domain/entities/collaborative_demand_detail.dart';
import '../../customWidges/custom_icon_button_return.dart';
import '../shared/home_app_bar_page.dart';

class CollaborativePage extends StatefulWidget {

  final int collaborativeDemandId;

  const CollaborativePage({Key? key, required this.collaborativeDemandId});

  @override
  State<CollaborativePage> createState() => _CollaborativePageState(collaborativeDemandId: collaborativeDemandId);
}

class _CollaborativePageState extends State<CollaborativePage> {
  final CollaborativeDemandRepository _repository = CollaborativeDemandRepository();

  final int collaborativeDemandId;

   _CollaborativePageState({
    required this.collaborativeDemandId,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CollaborativeDemandDetail>>(
      future: _repository.getCollaborativeDemandDetail(collaborativeDemandId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          return MaterialApp(
            title: 'Colaboración',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: DemandManagementScreen(demandDetails: snapshot.data!),
          );
        }
      },
    );
  }
}

class DemandManagementScreen extends StatelessWidget {
  final List<CollaborativeDemandDetail> demandDetails;

  const DemandManagementScreen({
    required this.demandDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Colaboración'),
            leading: CustomIconButtonReturn(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePageTabsPage(),
                  ),
                );
              },
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(20.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Campos flotantes superiores
                FloatingFields(demandDetails: this.demandDetails),
                const SizedBox(height: 20.0),
                // Campos de mayo 2024 a diciembre 2025
                DemandFields(demandDetails: this.demandDetails),
              ]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción al presionar el botón de guardar
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}

class FloatingFields extends StatelessWidget {
  final List<CollaborativeDemandDetail> demandDetails;

  const FloatingFields({
    required this.demandDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Cliente: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Text(
                  demandDetails.isNotEmpty ? demandDetails[0].customerName : '',
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Text(
                'Producto:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  demandDetails.isNotEmpty ? demandDetails[0].productName : '',
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Text(
                'Ciudad:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  demandDetails.isNotEmpty ? demandDetails[0].cityName : '',
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DemandFields extends StatelessWidget {
  final List<CollaborativeDemandDetail> demandDetails;

  const DemandFields({
    required this.demandDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildYearFields(demandDetails),
        SizedBox(height: 20.0),
        //buildYearFields(2025),
      ],
    );
  }

  Widget buildYearFields(List<CollaborativeDemandDetail> demandDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'año test',//demandDetails.toString(),
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        // Aquí puedes agregar los campos de texto para cada mes del año
        // Puedes personalizar el diseño según tus necesidades
        for (var month in demandDetails) ...[
          TextField(
            decoration: InputDecoration(
              labelText: month.yearMonth.toString(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          SizedBox(height: 10.0),
        ],
      ],
    );
  }


}
