import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'agregar_pago_screen.dart'; // Asegúrate de importar la nueva pantalla

class DetalleEstacionadoScreen extends StatefulWidget {
  final dynamic estacionado;

  DetalleEstacionadoScreen({required this.estacionado});

  @override
  _DetalleEstacionadoScreenState createState() =>
      _DetalleEstacionadoScreenState();
}

class _DetalleEstacionadoScreenState extends State<DetalleEstacionadoScreen> {
  late int tiempoEstacionado;

  @override
  void initState() {
    super.initState();
    tiempoEstacionado = widget.estacionado['tiempoEstacionado'] ??
        0; // Cargar el tiempo desde el widget
    fetchEstacionado(); // Asegura que el tiempo se actualice con la última información
  }

  Future<void> fetchEstacionado() async {
    final response = await http.get(
      Uri.parse(
          'http://localhost:8080/api/estacionados/${widget.estacionado['idEstacionados']}'),
    );

    if (response.statusCode == 200) {
      var estacionado = json.decode(response.body);
      setState(() {
        tiempoEstacionado = estacionado['tiempoEstacionado'] ?? 0;
      });
    } else {
      throw Exception('Error al cargar el estacionado');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalles del Estacionado',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor:
            const Color(0xFF00B2E3), // Mismo color que en PerfilScreen
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Datos del vehículo
              _buildProfileDetail(
                  'Patente', widget.estacionado['vehiculo']['patente']),
              const SizedBox(height: 10),
              _buildProfileDetail(
                  'Tiempo Estacionado', '$tiempoEstacionado minutos'),
              const SizedBox(height: 20),

              // Botón para pagar
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AgregarDetallePagoScreen(
                          vehiculoId: widget.estacionado['vehiculo']
                              ['idVehiculo']),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF00B2E3),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Pagar',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileDetail(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$label:',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
