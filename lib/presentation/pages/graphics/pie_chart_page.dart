import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../data/remoteData/collaborative_demand_repository.dart';
import '../../../domain/entities/report_global_assert.dart';

class PieChartPage extends StatefulWidget {
  @override
  _PieChartPageState createState() => _PieChartPageState();
}

class _PieChartPageState extends State<PieChartPage> {
  ReportGlobalAssert? salesData;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final CollaborativeDemandRepository _repository = CollaborativeDemandRepository();
      final data = await _repository.getGlobalAssertAsync();
      setState(() {
        salesData = data;
      });
    } catch (e) {
      // Manejar errores, por ejemplo, mostrando un diálogo de error
      print('Error cargando datos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gráfico de asertividad'),
      ),
      body: Center(
        child: salesData == null
            ? CircularProgressIndicator()
            : PieChart(
          PieChartData(
            sections: showingSections(salesData!),
            borderData: FlBorderData(show: false),
            sectionsSpace: 0,
            centerSpaceRadius: 40,
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(ReportGlobalAssert salesData) {
    return [
      PieChartSectionData(
        color: Colors.blue,
        value: salesData.percentage,
        title: '${salesData.percentage.toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.grey,
        value: 100 - salesData.percentage,
        title: '${(100 - salesData.percentage).toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ];
  }
}
