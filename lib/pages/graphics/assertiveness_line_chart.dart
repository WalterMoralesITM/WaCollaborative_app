import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import '../resources/app_colors.dart';
import 'package:wa_collaborative/pages/resources/app_colors.dart';

class SalesChartWidget extends StatefulWidget {
  const SalesChartWidget({super.key});
  @override
  _SalesChartWidgetState createState() => _SalesChartWidgetState();
}

class _SalesChartWidgetState extends State<SalesChartWidget> {
  List<int> quantities = [];

  @override
  void initState() {
    super.initState();
    fetchSalesData();
  }

  Future<void> fetchSalesData() async {
    final response = await http.get(Uri.parse('http://172.210.43.31/api/CollaborativeDemand/Sales?ShippingPointId=2&ProductId=2&ReportType=LastTwoYears'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      // Procesar los datos para obtener las cantidades
      setState(() {
        quantities = data.map((item) => item['quantitySaled']).cast<int>().toList();
      });
    } else {
      throw Exception('Error al cargar los datos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        // Configurar los datos de la gráfica
        lineBarsData: [
          LineChartBarData(
            spots: quantities.asMap().entries.map((entry) {
              return FlSpot(entry.key.toDouble(), entry.value.toDouble());
            }).toList(),
            isCurved: true,
            color: AppColors.mainGridLineColor,
            barWidth: 4,
            belowBarData: BarAreaData(show: false),
          ),
        ],
        // Configurar los ejes
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                /*getTitles: (value) {
              // Aquí puedes mostrar los meses o cualquier otra etiqueta en el eje X
              return value.toInt().toString();
            },*/
              )),
          leftTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
              )),
        ),
        // Configurar los márgenes de la gráfica
        borderData: FlBorderData(show: true),
      ),
    );
  }
}
