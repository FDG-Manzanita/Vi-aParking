import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';
import 'DetalleEstacionadoScreen.dart';
import 'agregar_estacionado.dart';
import 'agregar_incidente_screen.dart';

class EstacionadoScreen extends StatefulWidget {
  final int estacionamientoId;

  EstacionadoScreen({required this.estacionamientoId});

  @override
  _EstacionadoScreenState createState() => _EstacionadoScreenState();
}

class _EstacionadoScreenState extends State<EstacionadoScreen> {
  List<dynamic> estacionados = [];
  Map<int, Map<String, dynamic>> usuariosMap =
      {}; // Mapa para almacenar usuarios
  bool isLoading = true; // Estado de carga
  String errorMessage = ''; // Mensaje de error

  @override
  void initState() {
    super.initState();
    fetchEstacionados();
  }

  // Obtener los estacionados y sus usuarios
  Future<void> fetchEstacionados() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://localhost:8080/api/estacionados/estacionamiento/${widget.estacionamientoId}'),
      );

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        List<dynamic> newEstacionados = json.decode(response.body);

        if (!ListEquality().equals(estacionados, newEstacionados)) {
          // Obtener usuarios asociados
          await fetchUsuarios(newEstacionados);
          setState(() {
            estacionados = newEstacionados;
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = 'Error al cargar los autos estacionados';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error al conectar con el servidor';
        isLoading = false;
      });
    }
  }

  // Obtener datos de usuarios
  Future<void> fetchUsuarios(List<dynamic> estacionados) async {
    for (var estacionado in estacionados) {
      var vehiculo = estacionado['vehiculo'];
      int? usuarioId =
          int.tryParse(vehiculo['usuario']['idUsuario'].toString());

      if (usuarioId != null && !usuariosMap.containsKey(usuarioId)) {
        final usuario = await fetchUsuario(usuarioId);
        if (usuario != null) {
          usuariosMap[usuarioId] = usuario;
        }
      }
    }
  }

  // Obtener datos del usuario por ID
  Future<Map<String, dynamic>?> fetchUsuario(int usuarioId) async {
    final response = await http.get(
      Uri.parse('http://localhost:8080/api/usuarios/$usuarioId'),
    );

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return json.decode(response.body);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Estacionados',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF00B2E3),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF00B2E3), Colors.lightBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Se coloca el Divider dentro de un contenedor separado
            Divider(
              color: Colors.grey[300], // Color de la línea
              thickness: 1, // Grosor de la línea
              height: 1, // Altura del espacio entre la línea y los widgets
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AgregarEstacionadoScreen()),
                      );
                    },
                    icon: Icon(Icons.add),
                    label: Text('Agregar Estacionado'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CrearIncidenteScreen()),
                      );
                    },
                    icon: Icon(Icons.warning),
                    label: Text('Agregar Incidente'),
                  ),
                ],
              ),
            ),
            // Mostrar pantalla de carga o error
            isLoading
                ? Center(child: CircularProgressIndicator())
                : errorMessage.isNotEmpty
                    ? Center(
                        child: Text(errorMessage,
                            style: TextStyle(color: Colors.red)))
                    : Expanded(
                        child: ListView.builder(
                          itemCount: estacionados.length,
                          itemBuilder: (context, index) {
                            var estacionado = estacionados[index];
                            var vehiculo = estacionado['vehiculo'];
                            int? usuarioId = int.tryParse(
                                vehiculo['usuario']['idUsuario'].toString());
                            var usuario = usuariosMap[usuarioId];

                            String usuarioInfo = usuario != null
                                ? 'Usuario: ${usuario['nombre']} ${usuario['apellido']}'
                                : 'Usuario desconocido';

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetalleEstacionadoScreen(
                                            estacionado: estacionado),
                                  ),
                                );
                              },
                              child: buildCard(
                                patente: vehiculo['patente'],
                                usuarioInfo: usuarioInfo,
                              ),
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }

  // Método para construir el Card de usuario
  Widget buildCard({required String patente, required String usuarioInfo}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text('Patente: $patente'),
        subtitle: Text(usuarioInfo),
      ),
    );
  }
}
