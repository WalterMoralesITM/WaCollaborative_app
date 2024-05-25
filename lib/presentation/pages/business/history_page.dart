import 'dart:math';
import 'package:flutter/material.dart';
import '../../../data/remoteData/collaborative_demand_repository.dart';
import '../../customWidges/sized_box_line_break.dart';
import 'clients_filter_page.dart';

class HistoryPage extends StatefulWidget {
  final int collaborativeDemandId;

  const HistoryPage({super.key, required this.collaborativeDemandId});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<List<String>> tableData = [];
  late String customerName;
  late String productName;
  late String cityName;
  late List<int> years;

  @override
  void initState() {
    super.initState();
    _initializeTableData();
  }

  Future<void> _initializeTableData() async {
    final CollaborativeDemandRepository _repository = CollaborativeDemandRepository();

    final data = await _repository.getCollaborativeDemandSales(widget.collaborativeDemandId);

    if (data.isNotEmpty) {
      customerName = data[0].customerName;
      productName = data[0].productName;
      cityName = data[0].cityName;
    } else {
      customerName = 'Cliente Desconocido';
      productName = 'Producto Desconocido';
    }

    final Map<int, Map<int, double>> salesData = {};

    for (var entry in data) {
      int year = entry.yearMonth ~/ 100;
      int month = entry.yearMonth % 100;

      if (!salesData.containsKey(year)) {
        salesData[year] = {};
      }

      salesData[year]![month] = entry.quantitySaled;
    }

    years = salesData.keys.toList()..sort();

    tableData = List.generate(12, (index) {
      final month = _getMonthName(index + 1);
      return [
        month.substring(0, 3),
        for (var year in years)
          (salesData[year]?[index + 1] ?? 0).toString()
      ];
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historico'),
      ),
      body: tableData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : LayoutBuilder(
        builder: (context, constraints) {
          double columnWidth = constraints.maxWidth / (years.length + 1);

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBoxLineBreak(),
                Text(customerName),
                SizedBoxLineBreak(),
                Text(productName),
                SizedBoxLineBreak(),
                Text(cityName),
                DataTable(
                  columnSpacing: 0,
                  columns: [
                    DataColumn(label: Container(width: columnWidth, child: const Text('Mes'))),
                    for (var year in years)
                      DataColumn(label: Container(width: columnWidth, child: Text(year.toString()))),
                  ],
                  rows: List.generate(12, (index) {
                    return DataRow(cells: [
                      DataCell(Container(width: columnWidth, child: Text(tableData[index][0]))), // Mes
                      for (var i = 1; i < tableData[index].length; i++)
                        _buildDataCell(tableData[index][i], index, i, columnWidth), // Años
                    ]);
                  }),
                ),
              ],
            ),
          );
        },
      ),

    );
  }

  String _getMonthName(int monthNumber) {
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

  DataCell _buildDataCell(String value, int rowIndex, int colIndex, double columnWidth) {
    final prevValue = rowIndex > 0 ? double.tryParse(tableData[rowIndex - 1][colIndex]) ?? 0 : 0;
    final currentValue = double.tryParse(value) ?? 0;
    Color textColor;
    if (currentValue > prevValue) {
      textColor = Colors.green; // Verde si aumenta
    } else if (currentValue < prevValue) {
      textColor = Colors.red; // Rojo si disminuye
    } else {
      textColor = Colors.black; // Negro si es igual
    }
    return DataCell(
      Container(
        width: columnWidth,
        child: Text(
          value,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
