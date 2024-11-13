import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'agregar_estacionado.dart';
import 'agregar_incidente_screen.dart';
import 'agregar_pago_screen.dart';

class EstacionadoScreen extends StatefulWidget {
  final int estacionamientoId;

  EstacionadoScreen({required this.estacionamientoId});

  @override
  _EstacionadoScreenState createState() => _EstacionadoScreenState();
}

class _EstacionadoScreenState extends State<EstacionadoScreen> {
  List<dynamic> estacionados = [];

  @override
  void initState() {
    super.initState();
    fetchEstacionados();
  }

  // Función para obtener los estacionados para un estacionamiento específico
  Future<void> fetchEstacionados() async {
    final response = await http.get(
      Uri.parse(
          'http://localhost:8080/api/estacionados/estacionamiento/${widget.estacionamientoId}'),
    );

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      setState(() {
        estacionados = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load parked cars');
    }
  }

  // Función para obtener los detalles del usuario usando el usuario_id
  Future<Map<String, dynamic>?> fetchUsuario(int? usuarioId) async {
    if (usuarioId == null) return null;

    final response = await http.get(
      Uri.parse('http://localhost:8080/api/usuarios/$usuarioId'),
    );

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      Map<String, dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        return data;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estacionados'),
      ),
      body: Column(
        children: [
          // Botones para agregar incidente y agregar estacionado
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // Centra los botones
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
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
                SizedBox(width: 20), // Espacio entre los botones
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
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
              ],
            ),
          ),
          // Lista de vehículos estacionados
          Expanded(
            child: ListView.builder(
              itemCount: estacionados.length,
              itemBuilder: (context, index) {
                var vehiculo = estacionados[index]['vehiculo'];
                int? usuarioId =
                    int.tryParse(vehiculo['usuario_id'].toString());

                return FutureBuilder<Map<String, dynamic>?>(
                  future: fetchUsuario(usuarioId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListTile(
                        title: Text('Patente: ${vehiculo['patente']}'),
                        subtitle: Text('Cargando usuario...'),
                      );
                    } else if (snapshot.hasError) {
                      return ListTile(
                        title: Text('Patente: ${vehiculo['patente']}'),
                        subtitle: Text('Error al cargar usuario'),
                      );
                    } else if (snapshot.hasData && snapshot.data != null) {
                      var usuario = snapshot.data!;
                      String nombres = usuario['Nombres'] ?? 'Desconocido';
                      String apellidos = usuario['Apellidos'] ?? '';
                      return ListTile(
                        title: Text('Patente: ${vehiculo['patente']}'),
                        subtitle: Text('Usuario: $nombres $apellidos'),
                        trailing: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AgregarDetallePagoScreen(
                                  vehiculoId: vehiculo['id'],
                                ),
                              ),
                            );
                          },
                          child: Text('Pagar'),
                        ),
                      );
                    } else {
                      return ListTile(
                        title: Text('Patente: ${vehiculo['patente']}'),
                        subtitle: Text('Usuario desconocido'),
                        trailing: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AgregarDetallePagoScreen(
                                  vehiculoId: vehiculo['id'],
                                ),
                              ),
                            );
                          },
                          child: Text('Pagar'),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
