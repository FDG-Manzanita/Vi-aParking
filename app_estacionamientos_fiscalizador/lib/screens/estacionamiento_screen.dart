import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'estacionado_screen.dart'; // Importa la nueva pantalla

class EstacionamientoScreen extends StatefulWidget {
  final int sectorId;

  EstacionamientoScreen({required this.sectorId});

  @override
  _EstacionamientoScreenState createState() => _EstacionamientoScreenState();
}

class _EstacionamientoScreenState extends State<EstacionamientoScreen> {
  List<dynamic> estacionamientos = [];

  @override
  void initState() {
    super.initState();
    fetchEstacionamientos();
  }

  // Función para obtener los estacionamientos de un sector específico
  Future<void> fetchEstacionamientos() async {
    final response = await http.get(Uri.parse(
        'http://localhost:8080/api/estacionamientos/sector/${widget.sectorId}'));

    if (response.statusCode == 200) {
      setState(() {
        estacionamientos = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load parking lots');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Estacionamientos')),
      body: ListView.builder(
        itemCount: estacionamientos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(estacionamientos[index]['nombre']),
            subtitle: Text(
                'Cupos disponibles: ${estacionamientos[index]['cuposDisponibles']}'),
            onTap: () {
              // Al presionar el estacionamiento, navegar a la pantalla de estacionados
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EstacionadoScreen(
                    estacionamientoId: estacionamientos[index]
                        ['idEstacionamiento'],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
