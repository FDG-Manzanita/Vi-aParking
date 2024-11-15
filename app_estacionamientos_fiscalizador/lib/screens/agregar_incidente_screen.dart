import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CrearIncidenteScreen extends StatefulWidget {
  @override
  _CrearIncidenteScreenState createState() => _CrearIncidenteScreenState();
}

class _CrearIncidenteScreenState extends State<CrearIncidenteScreen> {
  String? selectedSector;
  String? selectedEstacionamiento;
  List<dynamic> sectores = [];
  List<dynamic> estacionamientos = [];
  TextEditingController tipoController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchSectores();
  }

  Future<void> _fetchSectores() async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/api/sectores'));

    if (response.statusCode == 200) {
      setState(() {
        sectores = json.decode(response.body);
      });
    } else {
      // Handle error
      print('Failed to load sectores');
    }
  }

  Future<void> _fetchEstacionamientos(int sectorId) async {
    final response = await http.get(Uri.parse(
        'http://localhost:8080/api/estacionamientos/sector/$sectorId'));

    if (response.statusCode == 200) {
      setState(() {
        estacionamientos = json.decode(response.body);
      });
    } else {
      // Handle error
      print('Failed to load estacionamientos');
    }
  }

  Future<void> _crearIncidente() async {
    if (selectedEstacionamiento != null &&
        tipoController.text.isNotEmpty &&
        descripcionController.text.isNotEmpty) {
      final response = await http.post(
        Uri.parse('http://localhost:8080/api/incidentes'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'tipo': tipoController.text,
          'descripcion': descripcionController.text,
          'estacionamiento': {'idEstacionamiento': selectedEstacionamiento},
          'sector': {'idSector': selectedSector},
          'fecha': DateTime.now().toIso8601String(),
        }),
      );

      if (response.statusCode == 201) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Incidente creado')),
        );

        // Regresar a la pantalla anterior
        Navigator.pop(context);
      } else {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create incidente')),
        );
      }
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Crear Incidente',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF00B2E3), // Color principal en Pantone 00B2E3
      ),
      body: Column(
        children: [
          // Contenedor que actúa como divider
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
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Icon(
                      Icons.report_problem,
                      size: 100,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Crear Incidente',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Por favor, completa los campos',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    DropdownButton<String>(
                      value: selectedSector,
                      hint: Text(
                        'Seleccione un sector',
                        style: TextStyle(color: Colors.white),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedSector = newValue;
                          selectedEstacionamiento =
                              null; // Reset estacionamiento
                          estacionamientos.clear(); // Clear estacionamientos
                        });
                        if (newValue != null) {
                          _fetchEstacionamientos(int.parse(newValue));
                        }
                      },
                      items: sectores.map<DropdownMenuItem<String>>((sector) {
                        return DropdownMenuItem<String>(
                          value: sector['idSector'].toString(),
                          child: Text(sector['nombre']),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16),
                    DropdownButton<String>(
                      value: selectedEstacionamiento,
                      hint: Text(
                        'Seleccione un estacionamiento',
                        style: TextStyle(color: Colors.white),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedEstacionamiento = newValue;
                        });
                      },
                      items: estacionamientos
                          .map<DropdownMenuItem<String>>((estacionamiento) {
                        return DropdownMenuItem<String>(
                          value:
                              estacionamiento['idEstacionamiento'].toString(),
                          child: Text(estacionamiento['nombre']),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: tipoController,
                      decoration: InputDecoration(
                        labelText: 'Tipo de Incidente',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF00B2E3)),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: descripcionController,
                      decoration: InputDecoration(
                        labelText: 'Descripción del Incidente',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF00B2E3)),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _crearIncidente,
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
                        'Crear Incidente',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
