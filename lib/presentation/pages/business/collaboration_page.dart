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

class DemandManagementScreen extends StatefulWidget {
  final List<CollaborativeDemandDetail> demandDetails;

  const DemandManagementScreen({
    required this.demandDetails,
  });

  @override
  _DemandManagementScreenState createState() => _DemandManagementScreenState();
}

class _DemandManagementScreenState extends State<DemandManagementScreen> {
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = widget.demandDetails
        .map((detail) => TextEditingController(text: detail.quantity.toString()))
        .toList();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _saveData() async {
    final CollaborativeDemandRepository _repository = CollaborativeDemandRepository();

    for (int i = 0; i < widget.demandDetails.length; i++) {
      double quantityInt = double.parse(_controllers[i].text);
      widget.demandDetails[i].quantity = quantityInt ;
    }
    await _repository.updateCollaborativeDemandDetail(widget.demandDetails);
  }

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
                FloatingFields(demandDetails: widget.demandDetails),
                const SizedBox(height: 20.0),
                // Campos de mayo 2024 a diciembre 2025
                DemandFields(demandDetails: widget.demandDetails, controllers: _controllers),
              ]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveData,
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
              const Text(
                'Cliente: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Text(
                  demandDetails.isNotEmpty ? demandDetails[0].customerName : '',
                  style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              const Text(
                'Producto:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  demandDetails.isNotEmpty ? demandDetails[0].productName : '',
                  style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              const Text(
                'Ciudad:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  demandDetails.isNotEmpty ? demandDetails[0].cityName : '',
                  style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
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
  final List<TextEditingController> controllers;

  const DemandFields({
    required this.demandDetails,
    required this.controllers,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildYearFields(demandDetails, controllers),
        const SizedBox(height: 20.0),
      ],
    );
  }

  Widget buildYearFields(List<CollaborativeDemandDetail> demandDetails, List<TextEditingController> controllers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Periodos que tienes para colaborar',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        for (var i = 0; i < demandDetails.length; i++) ...[
          TextField(
            controller: controllers[i],
            decoration: InputDecoration(
              labelText: getLaberYearAndMonth(demandDetails[i].yearMonth.toString()),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          const SizedBox(height: 10.0),
        ],
      ],
    );
  }

  String getLaberYearAndMonth(String yearMonth) {
    String year = yearMonth.toString().substring(0, 4);
    String month = yearMonth.toString().substring(4, 6);
    String monthName = getMonthName(month);

    return "$monthName de $year";
  }

  String getMonthName(String monthNumber) {
    Map<String, String> meses = {
      "1": "Enero",
      "2": "Febrero",
      "3": "Marzo",
      "4": "Abril",
      "5": "Mayo",
      "6": "Junio",
      "7": "Julio",
      "8": "Agosto",
      "9": "Septiembre",
      "01": "Enero",
      "02": "Febrero",
      "03": "Marzo",
      "04": "Abril",
      "05": "Mayo",
      "06": "Junio",
      "07": "Julio",
      "08": "Agosto",
      "09": "Septiembre",
      "10": "Octubre",
      "11": "Noviembre",
      "12": "Diciembre"
    };

    return meses[monthNumber] ?? "Número de mes inválido";
  }
}
