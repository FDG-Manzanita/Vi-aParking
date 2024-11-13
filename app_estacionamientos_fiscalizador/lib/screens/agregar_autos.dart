import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AgregarVehiculoScreen extends StatefulWidget {
  @override
  _AgregarVehiculoScreenState createState() => _AgregarVehiculoScreenState();
}

class _AgregarVehiculoScreenState extends State<AgregarVehiculoScreen> {
  TextEditingController patenteController = TextEditingController();
  List<dynamic> usuariosTipo2 = [];
  String? usuarioSeleccionado;

  @override
  void initState() {
    super.initState();
    fetchUsuariosTipo2();
  }

  // Método para obtener los usuarios tipo 2 desde la API
  Future<void> fetchUsuariosTipo2() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://localhost:8080/api/usuarios/buscarPorTipo?tipoUsuario=2'),
      );

      if (response.statusCode == 200) {
        setState(() {
          usuariosTipo2 = json.decode(response.body);
          print('Usuarios cargados: $usuariosTipo2'); // Depuración
        });
      } else {
        print('Error al obtener usuarios tipo 2');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al obtener usuarios tipo 2')),
        );
      }
    } catch (e) {
      print('Excepción: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error en la conexión a la API')),
      );
    }
  }

  // Método para agregar un vehículo
  Future<void> agregarVehiculo() async {
    if (patenteController.text.isNotEmpty && usuarioSeleccionado != null) {
      final Map<String, dynamic> vehiculoData = {
        "patente": patenteController.text,
        "usuario": {
          "idUsuario":
              int.parse(usuarioSeleccionado!), // Solo el ID del usuario
        }
      };

      try {
        final response = await http.post(
          Uri.parse('http://localhost:8080/api/vehiculos'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(vehiculoData),
        );

        // Verifica la respuesta
        if (response.statusCode == 201) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Vehículo agregado exitosamente')),
          );
        } else {
          print('Error: ${response.body}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al agregar el vehículo')),
          );
        }
      } catch (e) {
        print('Excepción al agregar vehículo: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Error en la conexión a la API al agregar el vehículo')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agregar Vehículo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo para la patente del vehículo
            TextField(
              controller: patenteController,
              decoration: InputDecoration(labelText: 'Patente del Vehículo'),
            ),
            SizedBox(height: 16),
            // Verifica que la lista de usuarios no esté vacía
            usuariosTipo2.isEmpty
                ? Center(
                    child:
                        CircularProgressIndicator()) // Muestra un cargando mientras se cargan los usuarios
                : DropdownButton<String>(
                    hint: Text('Selecciona Usuario Tipo 2'),
                    value: usuarioSeleccionado,
                    items:
                        usuariosTipo2.map<DropdownMenuItem<String>>((usuario) {
                      return DropdownMenuItem<String>(
                        value: usuario['idUsuario'].toString(),
                        child:
                            Text('${usuario['nombre']} ${usuario['apellido']}'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        usuarioSeleccionado = value;
                        print(
                            'Usuario seleccionado: $usuarioSeleccionado'); // Depuración
                      });
                    },
                  ),
            SizedBox(height: 16),
            // Botón para agregar el vehículo
            ElevatedButton(
              onPressed: agregarVehiculo,
              child: Text('Agregar Vehículo'),
            ),
          ],
        ),
      ),
    );
  }
}
