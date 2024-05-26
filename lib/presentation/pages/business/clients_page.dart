import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/repositories/customer_repository.dart';
import '../../../domain/entities/customer_basic_contact.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({super.key});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  late Future<List<CustomerBasicContact>> futureClients;
  late TextEditingController _searchController;
  List<CustomerBasicContact> _clients = [];
  List<CustomerBasicContact> _filteredClients = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    futureClients = getCustomersByUser();
    futureClients.then((clients) {
      setState(() {
        _clients = clients;
        _filteredClients = clients;
      });
    });
    _searchController.addListener(_filterClients);
  }

  Future<List<CustomerBasicContact>> getCustomersByUser() async {
    final CustomerRepository _repository = CustomerRepository();
    return _repository.getCustomerByUserAsync();
  }

  Future<void> _launchEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launchUrl(emailLaunchUri);
  }

  Future<void> _launchPhone(String phone) async {
    final Uri phoneLaunchUri = Uri(
      scheme: 'tel',
      path: phone,
    );
    await launchUrl(phoneLaunchUri);
  }

  Future<void> _launchWhatsApp(String phone) async {
    final Uri whatsappLaunchUri = Uri(
      scheme: 'https',
      path: 'wa.me/$phone',
    );
    await launchUrl(whatsappLaunchUri);
  }

  void _filterClients() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredClients = _clients.where((client) {
        return client.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Directorio de Clientes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              //width: 200,  // Ajusta el ancho a tu preferencia
              height: 40,  // Ajusta la altura a tu preferencia
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Buscar Cliente',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            )
          ),
          Expanded(
            child: FutureBuilder<List<CustomerBasicContact>>(
              future: futureClients,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error al cargar los datos'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No se encontraron clientes'));
                } else {
                  return ListView.builder(
                    itemCount: _filteredClients.length,
                    itemBuilder: (context, index) {
                      final client = _filteredClients[index];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                client.name,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('Dirección: ${client.address}'),
                              Text('Email: ${client.email}'),
                              Text('Teléfono: ${client.numberPhone}'),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.email),
                                    onPressed: () => _launchEmail(client.email),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.phone),
                                    onPressed: () => _launchPhone(client.numberPhone),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.message),
                                    onPressed: () => _launchWhatsApp(client.numberPhone),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
