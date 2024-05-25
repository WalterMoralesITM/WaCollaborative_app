import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wa_collaborative/presentation/pages/business/clients_page.dart';
import 'package:wa_collaborative/presentation/pages/business/history_page.dart';
import '../../../data/remoteData/collaborative_demand_repository.dart';
import '../../../domain/entities/collaborative_demand_detail.dart';
import '../../customWidges/custom_icon_button_return.dart';
import '../../customWidges/sized_box_line_break.dart';
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
          return const Scaffold(
            body:  Center(
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
  bool _isSaving = false;  // Nueva variable de estado

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



  navigateToPage(BuildContext context, int demandId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HistoryPage(collaborativeDemandId: demandId),
      ),
    );
  }

  void _viewReport() async {
    int demandId = widget.demandDetails[0].collaborativeDemandId;
    navigateToPage(context, demandId);
  }

  void _saveData() async {
    setState(() {
      _isSaving = true;  // Indicamos que se está guardando
    });

    final CollaborativeDemandRepository _repository = CollaborativeDemandRepository();

    for (int i = 0; i < widget.demandDetails.length; i++) {
      String quantityText = _controllers[i].text == null || _controllers[i].text.isEmpty ? "0": _controllers[i].text;
      double quantityInt = double.parse(quantityText);
      widget.demandDetails[i].quantity = quantityInt;
    }
    await _repository.updateCollaborativeDemandDetail(widget.demandDetails);

    setState(() {
      _isSaving = false;  // Indicamos que se ha terminado de guardar
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
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
          if (_isSaving)  // Indicador de carga
            Container(
              color: Colors.black45,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _viewReport,
            child: const Icon(Icons.access_time_outlined),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _saveData,
            child: const Icon(Icons.save),
          ),
        ],
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(demandDetails.isNotEmpty ? demandDetails[0].customerName : ''),
              SizedBoxLineBreak(),
              Text(demandDetails.isNotEmpty ? demandDetails[0].productName : ''),
              SizedBoxLineBreak(),
              Text(demandDetails.isNotEmpty ? demandDetails[0].cityName : ''),
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
