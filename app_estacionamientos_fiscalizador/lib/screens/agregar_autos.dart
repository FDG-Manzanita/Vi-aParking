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

  Future<void> fetchUsuariosTipo2() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://localhost:8080/api/usuarios/buscarPorTipo?tipoUsuario=2'),
      );
      if (response.statusCode == 200) {
        setState(() {
          usuariosTipo2 = json.decode(response.body);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al obtener usuarios tipo 2')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error en la conexión a la API')));
    }
  }

  Future<void> agregarVehiculo() async {
    if (patenteController.text.isNotEmpty && usuarioSeleccionado != null) {
      final Map<String, dynamic> vehiculoData = {
        "patente": patenteController.text,
        "usuario": {"idUsuario": int.parse(usuarioSeleccionado!)}
      };
      try {
        final response = await http.post(
          Uri.parse('http://localhost:8080/api/vehiculos'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(vehiculoData),
        );
        if (response.statusCode == 201) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Vehículo agregado exitosamente')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error al agregar el vehículo')));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al agregar el vehículo')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Por favor, completa todos los campos')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agregar Vehículo',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF00B2E3),
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
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF00B2E3), Colors.lightBlue],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.directions_car,
                          size: 100, color: Colors.white),
                      SizedBox(height: 20),
                      Text(
                        'Agregar Vehículo',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(height: 20),
                      _buildTextField('Patente del Vehículo', Icons.car_repair),
                      SizedBox(height: 20),
                      usuariosTipo2.isEmpty
                          ? Center(child: CircularProgressIndicator())
                          : DropdownButton<String>(
                              hint: Text(
                                'Selecciona Usuario Tipo 2',
                                style: TextStyle(color: Colors.white),
                              ),
                              value: usuarioSeleccionado,
                              items: usuariosTipo2
                                  .map<DropdownMenuItem<String>>((usuario) {
                                return DropdownMenuItem<String>(
                                  value: usuario['idUsuario'].toString(),
                                  child: Text(
                                      '${usuario['nombre']} ${usuario['apellido']}'),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  usuarioSeleccionado = value;
                                });
                              },
                            ),
                      SizedBox(height: 30),
                      _styledButton('Agregar Vehículo', agregarVehiculo),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String hintText, IconData icon) {
    return TextField(
      controller: patenteController,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon, color: Color(0xFF00B2E3)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _styledButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.blueAccent,
        backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Text(text, style: TextStyle(color: Colors.black, fontSize: 18)),
    );
  }
}
