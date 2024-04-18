import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wa_collaborative/pages/business/clients_filter_page.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({super.key});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  late List<List<String>> tableData;

  @override
  void initState() {
    super.initState();
    // Inicializar la tabla con datos aleatorios
    tableData = List.generate(12, (index) {
      final month = _getMonthName(index + 1);
      return [
        month.substring(0, 3),
        _getRandomData(),
        _getRandomData(),
        _getRandomData(),
        _getRandomData(),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              const Text("Cliente 01"),
              const SizedBox(height: 16),
              const Text("Producto 21"),
              DataTable(
                columns: const [
                  DataColumn(label: Text('Mes')),
                  DataColumn(label: Text('2021')),
                  DataColumn(label: Text('2022')),
                  DataColumn(label: Text('2023')),
                  DataColumn(label: Text('2024')),
                ],
                rows: List.generate(12, (index) {
                  return DataRow(cells: [
                    DataCell(Text(tableData[index][0])), // Mes
                    _buildDataCell(tableData[index][1], index, 1), // Año 2021
                    _buildDataCell(tableData[index][2], index, 2), // Año 2022
                    _buildDataCell(tableData[index][3], index, 3), // Año 2023
                    _buildDataCell(tableData[index][4], index, 4), // Año 2024
                  ]);
                }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: () {
            setState(() {
              // Cambiar el estado de la tabla con nuevos datos aleatorios
              tableData = List.generate(12, (index) {
                final month = _getMonthName(index + 1);
                return [
                  month.substring(0, 3),
                  _getRandomData(),
                  _getRandomData(),
                  _getRandomData(),
                  _getRandomData(),
                ];
              });
            });
          },
          child: const Icon(Icons.refresh),
        ),
        const SizedBox(height: 16),
        FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ClientsFilterPage()),
            );
          },
          child: Icon(Icons.filter_alt),
        ),
      ],
    ),
   );
  }
  String _getMonthName(int monthNumber) {
    // Obtener el nombre del mes a partir de su número
    switch (monthNumber) {
      case 1:
        return 'Enero';
      case 2:
        return 'Febrero';
      case 3:
        return 'Marzo';
      case 4:
        return 'Abril';
      case 5:
        return 'Mayo';
      case 6:
        return 'Junio';
      case 7:
        return 'Julio';
      case 8:
        return 'Agosto';
      case 9:
        return 'Septiembre';
      case 10:
        return 'Octubre';
      case 11:
        return 'Noviembre';
      case 12:
        return 'Diciembre';
      default:
        return '';
    }
  }

  String _getRandomData() {
    // Generar datos aleatorios entre 0 y 40
    final random = Random();
    return '${random.nextInt(41)}';
  }

  DataCell _buildDataCell(String value, int rowIndex, int colIndex) {
    // Construir una celda de datos personalizada con el color correspondiente
    final prevValue = rowIndex > 0 ? int.tryParse(tableData[rowIndex - 1][colIndex]) ?? 0 : 0;
    final currentValue = int.tryParse(value) ?? 0;
    Color textColor;
    if (currentValue > prevValue) {
      textColor = Colors.green; // Verde si aumenta
    } else if (currentValue < prevValue) {
      textColor = Colors.red; // Rojo si disminuye
    } else {
      textColor = Colors.black; // Negro si es igual
    }
    return DataCell(
      Text(
        value,
        style: TextStyle(color: textColor),
      ),
    );
  }
}




