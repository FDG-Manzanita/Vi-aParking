import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart'; // Para comparar las listas
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
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fetchEstacionados();
    // Inicializa el timer para actualizar la lista cada 10 segundos
    _timer =
        Timer.periodic(Duration(seconds: 10), (Timer t) => fetchEstacionados());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Obtener los estacionados para un estacionamiento específico
  Future<void> fetchEstacionados() async {
    final response = await http.get(
      Uri.parse(
          'http://localhost:8080/api/estacionados/estacionamiento/${widget.estacionamientoId}'),
    );

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      List<dynamic> newEstacionados = json.decode(response.body);

      // Comparar los datos actuales con los nuevos
      if (!ListEquality().equals(estacionados, newEstacionados)) {
        setState(() {
          estacionados = newEstacionados; // Actualiza solo si hay cambios
        });
      }
    } else {
      throw Exception('Error al cargar los autos estacionados');
    }
  }

  Future<Map<String, dynamic>?> fetchUsuario(int? usuarioId) async {
    if (usuarioId == null) return null;
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
        title: Text('Estacionados'),
        backgroundColor: Color(0xFF00B2E3), // Color de fondo del app bar
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
            Expanded(
              child: ListView.builder(
                itemCount: estacionados.length,
                itemBuilder: (context, index) {
                  var estacionado = estacionados[index];
                  var vehiculo = estacionado['vehiculo'];
                  int? usuarioId =
                      int.tryParse(vehiculo['usuario_id'].toString());

                  return GestureDetector(
                    onTap: () {
                      // Navegar a la pantalla de detalles
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetalleEstacionadoScreen(
                              estacionado: estacionado),
                        ),
                      );
                    },
                    child: FutureBuilder<Map<String, dynamic>?>(
                      future: fetchUsuario(usuarioId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                            child: ListTile(
                              contentPadding: EdgeInsets.all(16),
                              title: Text('Patente: ${vehiculo['patente']}'),
                              subtitle: Text('Cargando usuario...'),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                            child: ListTile(
                              contentPadding: EdgeInsets.all(16),
                              title: Text('Patente: ${vehiculo['patente']}'),
                              subtitle: Text('Error al cargar usuario'),
                            ),
                          );
                        } else if (snapshot.hasData && snapshot.data != null) {
                          var usuario = snapshot.data!;
                          return Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                            child: ListTile(
                              contentPadding: EdgeInsets.all(16),
                              title: Text('Patente: ${vehiculo['patente']}'),
                              subtitle: Text(
                                  'Usuario: ${usuario['Nombres']} ${usuario['Apellidos']}'),
                            ),
                          );
                        } else {
                          return Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                            child: ListTile(
                              contentPadding: EdgeInsets.all(16),
                              title: Text('Patente: ${vehiculo['patente']}'),
                              subtitle: Text('Usuario desconocido'),
                            ),
                          );
                        }
                      },
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
}
