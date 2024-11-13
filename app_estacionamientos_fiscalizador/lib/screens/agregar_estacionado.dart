import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_estacionamientos_fiscalizador/screens/agregar_autos.dart'; // Asegúrate de importar la pantalla

class AgregarEstacionadoScreen extends StatefulWidget {
  @override
  _AgregarEstacionadoScreenState createState() =>
      _AgregarEstacionadoScreenState();
}

class _AgregarEstacionadoScreenState extends State<AgregarEstacionadoScreen> {
  List<dynamic> estacionamientos = [];
  List<dynamic> vehiculos = [];
  String? estacionamientoSeleccionado;
  String? vehiculoSeleccionado;

  @override
  void initState() {
    super.initState();
    fetchEstacionamientos();
    fetchVehiculos();
  }

  Future<void> fetchEstacionamientos() async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/api/estacionamientos'));
    if (response.statusCode == 200) {
      setState(() {
        estacionamientos = json.decode(response.body);
      });
    } else {
      // Manejo de error
      print('Error al cargar estacionamientos');
    }
  }

  Future<void> fetchVehiculos() async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/api/vehiculos'));
    if (response.statusCode == 200) {
      setState(() {
        vehiculos = json.decode(response.body);
      });
    } else {
      // Manejo de error
      print('Error al cargar vehiculos');
    }
  }

  Future<void> agregarEstacionado() async {
    if (estacionamientoSeleccionado != null && vehiculoSeleccionado != null) {
      final response = await http.post(
        Uri.parse('http://localhost:8080/api/estacionados'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'estacionamiento': {'idEstacionamiento': estacionamientoSeleccionado},
          'vehiculo': {'idVehiculo': vehiculoSeleccionado},
        }),
      );

      if (response.statusCode == 201) {
        // Si la solicitud es exitosa, regresamos a la pantalla anterior
        Navigator.pop(context);
      } else {
        // Si algo falla, mostramos un mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al agregar el estacionado')),
        );
      }
    } else {
      // Mostrar mensaje si falta completar algún campo
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Por favor selecciona un estacionamiento y un vehículo')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agregar Estacionado')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              hint: Text('Seleccionar Estacionamiento'),
              value: estacionamientoSeleccionado,
              items: estacionamientos.map<DropdownMenuItem<String>>((item) {
                return DropdownMenuItem<String>(
                  value: item['idEstacionamiento'].toString(),
                  child: Text(item['nombre']),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  estacionamientoSeleccionado = value;
                });
              },
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              hint: Text('Seleccionar Vehículo'),
              value: vehiculoSeleccionado,
              items: vehiculos.map<DropdownMenuItem<String>>((item) {
                return DropdownMenuItem<String>(
                  value: item['idVehiculo'].toString(),
                  child: Text(item['patente']),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  vehiculoSeleccionado = value;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: agregarEstacionado,
              child: Text('Agregar Estacionado'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla de agregar vehículo
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AgregarVehiculoScreen()),
                );
              },
              child: Text('Agregar Vehículo'),
            ),
          ],
        ),
      ),
    );
  }
}
