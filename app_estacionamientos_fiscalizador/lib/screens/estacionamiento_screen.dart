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
      appBar: AppBar(
        title: Text(
          'Estacionamientos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF00B2E3), // Color de fondo del app bar
      ),
      body: Column(
        children: [
          // Divider entre el AppBar y el body
          Container(
            color: Colors.grey[300], // Color de la línea
            height: 1, // Grosor de la línea
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF00B2E3), Colors.lightBlue],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: ListView.builder(
                itemCount: estacionamientos.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      title: Text(
                        estacionamientos[index]['nombre'],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Cupos disponibles: ${estacionamientos[index]['cuposDisponibles']}',
                        style: TextStyle(color: Colors.black54),
                      ),
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
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
