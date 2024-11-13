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
      appBar: AppBar(title: Text('Crear Incidente')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedSector,
              hint: Text('Seleccione un sector'),
              onChanged: (String? newValue) {
                setState(() {
                  selectedSector = newValue;
                  selectedEstacionamiento = null; // Reset estacionamiento
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
              hint: Text('Seleccione un estacionamiento'),
              onChanged: (String? newValue) {
                setState(() {
                  selectedEstacionamiento = newValue;
                });
              },
              items: estacionamientos
                  .map<DropdownMenuItem<String>>((estacionamiento) {
                return DropdownMenuItem<String>(
                  value: estacionamiento['idEstacionamiento'].toString(),
                  child: Text(estacionamiento['nombre']),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            TextField(
              controller: tipoController,
              decoration: InputDecoration(labelText: 'Tipo de Incidente'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: descripcionController,
              decoration:
                  InputDecoration(labelText: 'Descripción del Incidente'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _crearIncidente,
              child: Text('Crear Incidente'),
            ),
          ],
        ),
      ),
    );
  }
}
