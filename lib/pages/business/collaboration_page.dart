import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../customWidges/custom_icon_button_return.dart';
import '../shared/home_app_bar_page.dart';

class CollaborativePage extends StatefulWidget {
  const CollaborativePage({super.key});

  @override
  State<CollaborativePage> createState() => _CollaborativePageState();
}

class _CollaborativePageState extends State<CollaborativePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Colaboración',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DemandManagementScreen(),
    );
  }
}

class DemandManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Colaboración'),
            leading: CustomIconButtonReturn(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePageTabsPage()),
                );
              },
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(20.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Campos flotantes superiores
                FloatingFields(),
                const SizedBox(height: 20.0),
                // Campos de mayo 2024 a diciembre 2025
                DemandFields(),
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
      //drawer: const MenuDrawerPage()
    );
  }
}

class FloatingFields extends StatelessWidget {
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
                'Nombre de Cliente: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Text(
                  'Almacenes exito lo mejor de colombia señores',
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
                   'Producto ABC',
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
                  'Ciudad XYZ',
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
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildYearFields(2024),
        SizedBox(height: 20.0),
        buildYearFields(2025),
      ],
    );
  }

  Widget buildYearFields(int year) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          year.toString(),
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        // Aquí puedes agregar los campos de texto para cada mes del año
        // Puedes personalizar el diseño según tus necesidades
        for (var month in months) ...[
          TextField(
            decoration: InputDecoration(
              labelText: month,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          SizedBox(height: 10.0),
        ],
      ],
    );
  }

  // Lista de meses
  final List<String> months = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre',
  ];
}


