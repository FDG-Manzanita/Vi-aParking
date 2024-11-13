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

  // Obtener lista de estacionamientos
  Future<void> fetchEstacionamientos() async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/api/estacionamientos'));
    if (response.statusCode == 200) {
      setState(() {
        estacionamientos = json.decode(response.body);
      });
    } else {
      print('Error al cargar estacionamientos');
    }
  }

  // Obtener lista de vehículos
  Future<void> fetchVehiculos() async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/api/vehiculos'));
    if (response.statusCode == 200) {
      setState(() {
        vehiculos = json.decode(response.body);
      });
    } else {
      print('Error al cargar vehiculos');
    }
  }

  // Agregar vehículo estacionado con tiempo inicial en 0
  Future<void> agregarEstacionado() async {
    if (estacionamientoSeleccionado != null && vehiculoSeleccionado != null) {
      final response = await http.post(
        Uri.parse('http://localhost:8080/api/estacionados'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'estacionamiento': {'idEstacionamiento': estacionamientoSeleccionado},
          'vehiculo': {'idVehiculo': vehiculoSeleccionado},
          'tiempoEstacionado': 0 // Tiempo inicial en 0
        }),
      );

      if (response.statusCode == 201) {
        // Regresar a la pantalla anterior si se agrega correctamente
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al agregar el estacionado')),
        );
      }
    } else {
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
      appBar: AppBar(
        title: Text('Agregar Estacionado'),
        backgroundColor: Color(0xFF00B2E3), // Color principal en Pantone 00B2E3
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF00B2E3), Colors.lightBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.car_repair,
                  size: 100,
                  color: Colors.white,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Agregar Estacionado',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Selecciona un estacionamiento y un vehículo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Color(0xFF00B2E3), // Color del texto
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Agregar Estacionado',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AgregarVehiculoScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Color(0xFF00B2E3), // Color del texto
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Agregar Vehículo',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
