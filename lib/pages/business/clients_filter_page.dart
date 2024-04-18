import 'package:flutter/material.dart';

import '../shared/home_app_bar_page.dart';

class ClientsFilterPage extends StatefulWidget {
  const ClientsFilterPage({super.key});

  @override
  State<ClientsFilterPage> createState() => _ClientsFilterPageState();
}

class _ClientsFilterPageState extends State<ClientsFilterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              hint: Text('Seleccionar Cliente'),
              // Populate dropdown with fake client data
              items: List.generate(
                10,
                    (index) => DropdownMenuItem(
                  child: Text('Cliente ${index + 1}'),
                  value: 'Cliente ${index + 1}',
                ),
              ),
              onChanged: (String? value) {
                // Handle client selection
              },
            ),
            SizedBox(height: 16.0),
            DropdownButton<String>(
              hint: Text('Seleccionar Producto'),
              // Populate dropdown with fake product data based on selected client
              items: List.generate(
                15,
                    (index) => DropdownMenuItem(
                  child: Text('Producto ${index + 1}'),
                  value: 'Producto ${index + 1}',
                ),
              ),
              onChanged: (String? value) {
                // Handle product selection
              },
            ),
            SizedBox(height: 16.0),
            DropdownButton<String>(
              hint: Text('Seleccionar Tipo de Informe'),
              // Predefined report types
              items: ['Último Año', 'Últimos 2 Años', 'Últimos 3 Años']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                // Handle report type selection
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {

              },
              child: Text('Ejecutar'),
            ),
            SizedBox(height: 16.0),
            // Widget to display report results based on selected criteria
            // Implement this based on the selected report type
          ],
        ),
      ),
    );
  }
}
