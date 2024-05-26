import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../data/remoteData/collaborative_demand_repository.dart';

class BarChartSample2 extends StatefulWidget {
  final int collaborativeDemandId;
  BarChartSample2({super.key, required this.collaborativeDemandId});

  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<BarChartSample2> {
  final List<FlSpot> projectedData = [];
  final List<FlSpot> actualData = [];
  late String yearInitial = '';

  @override
  void initState() {
    super.initState();
    // Llama a la función para cargar los datos
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final CollaborativeDemandRepository _repository = CollaborativeDemandRepository();

      final data = await _repository.getDetailHistoryAssertAsync(widget.collaborativeDemandId);

      for (var row in data) {
        var month = double.parse(row.yearMonth.toString().substring(4, 6));
        var quantity = row.quantity;
        var quantitySale = row.quantitySale;
        yearInitial = row.yearMonth.toString().substring(0, 4);

        var projectedRegister = FlSpot(month, quantity);
        var actualRegister = FlSpot(month, quantitySale);
        setState(() {
          projectedData.add(projectedRegister);
          actualData.add(actualRegister);
        });
      }
    } catch (e) {
      // Manejar errores, por ejemplo, mostrando un diálogo de error
      print('Error cargando datos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Extraer el año del primer dato
    String year = '0';  // Inicializar con un valor por defecto
    if (projectedData.isNotEmpty) {
      year = yearInitial; // Suponiendo que todos los datos son del mismo año
    }

    return Scaffold(
      appBar: AppBar(title: Text('Proyectado vs Real $year')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: projectedData,
                isCurved: true,
                color: Colors.blue,
                barWidth: 4,
                belowBarData: BarAreaData(show: false),
                dotData: FlDotData(show: true),
              ),
              LineChartBarData(
                spots: actualData,
                isCurved: true,
                color: Colors.red,
                barWidth: 4,
                belowBarData: BarAreaData(show: false),
                dotData: FlDotData(show: true),
              ),
            ],
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    const style = TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    );
                    switch (value.toInt()) {
                      case 1:
                        return Text('Ene', style: style);
                      case 2:
                        return Text('Feb', style: style);
                      case 3:
                        return Text('Mar', style: style);
                      case 4:
                        return Text('Abr', style: style);
                      case 5:
                        return Text('May', style: style);
                      case 6:
                        return Text('Jun', style: style);
                      case 7:
                        return Text('Jul', style: style);
                      case 8:
                        return Text('Ago', style: style);
                      case 9:
                        return Text('Sep', style: style);
                      case 10:
                        return Text('Oct', style: style);
                      case 11:
                        return Text('Nov', style: style);
                      case 12:
                        return Text('Dic', style: style);
                    }
                    return Text('');
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    const style = TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    );
                    if (value % 50 == 0) {
                      return Text('${value.toInt()}', style: style);
                    }
                    return Text('');
                  },
                ),
              ),
            ),
            gridData: FlGridData(show: true),
            borderData: FlBorderData(show: true),
            minX: 1,
            maxX: 12,
            minY: 0,
            maxY: 200,
          ),
        ),
      ),
    );
  }
}
