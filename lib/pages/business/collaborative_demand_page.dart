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
    return MaterialApp(
      title: 'Demanda Colaborada',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DemandCollaborationScreen(),
    );
  }
}


class DemandCollaborationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demanda Colaborada'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Filtro',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(text: 'Pendiente'),
                    Tab(text: 'Colaborado'),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: TabBarView(
                    children: [
                      DemandList(status: 'Pendiente'),
                      DemandList(status: 'Colaborado'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Acción cuando se presiona el botón Exportar
                },
                child: Text('Exportar'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Acción cuando se presiona el botón Aprobar
                },
                child: Text('Aprobar'),
              ),
            ],
          ),
        ],
      ),
      drawer: MenuDrawerPage(),
    );
  }
}

class DemandList extends StatelessWidget {
  final String status;

  DemandList({required this.status});

  @override
  Widget build(BuildContext context) {
    // Simulando datos de demanda estática
    List<Map<String, String>> demandData = List.generate(
      20,
          (index) => {
        'cliente': 'Cliente $index',
        'producto': 'Producto $index',
        'estado': status,
      },
    );

    return ListView.builder(
      shrinkWrap: true,
      itemCount: demandData.length,
      itemBuilder: (context, index) {
        return DemandCard(
          cliente: demandData[index]['cliente']!,
          producto: demandData[index]['producto']!,
          estado: demandData[index]['estado']!,
        );
      },
    );
  }
}

class DemandCard extends StatelessWidget {
  final String cliente;
  final String producto;
  final String estado;

  DemandCard({
    required this.cliente,
    required this.producto,
    required this.estado,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text('Cliente: $cliente'),
        subtitle: Text('Producto: $producto\nEstado: $estado'),
        trailing: ElevatedButton(
          onPressed: () {
            // Acción cuando se presiona el botón Colaborar
          },
          child: Text('Colaborar'),
        ),
      ),
    );
  }
}