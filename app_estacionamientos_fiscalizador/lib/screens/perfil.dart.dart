import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PerfilScreen extends StatefulWidget {
  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  Map<String, dynamic>? usuarioData;

  @override
  void initState() {
    super.initState();
    _cargarDatosUsuario();
  }

  Future<void> _cargarDatosUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? idUsuario = prefs.getInt('id_usuario');
    if (idUsuario != null) {
      final response = await http.get(
        Uri.parse('http://localhost:8080/api/usuarios/$idUsuario'),
      );

      if (response.statusCode == 200) {
        setState(() {
          usuarioData = json.decode(response.body);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF00B2E3),
      ),
      body: usuarioData == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Avatar de perfil
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                        'https://i0.wp.com/codigoespagueti.com/wp-content/uploads/2023/07/jujutsu-kaisen-gojo-fanart-husbando.jpg'),
                  ),
                  const SizedBox(height: 20),
                  // Nombre y Apellidos
                  Text(
                    '${usuarioData?['nombre'] ?? 'N/A'} ${usuarioData?['apellido'] ?? 'N/A'}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Detalles del perfil
                  _buildProfileDetail('Email', usuarioData?['email'] ?? 'N/A'),
                  _buildProfileDetail('Teléfono',
                      usuarioData?['telefono']?.toString() ?? 'N/A'),
                  _buildProfileDetail(
                      'Dirección', usuarioData?['Direccion'] ?? 'N/A'),
                  _buildProfileDetail('Tipo Usuario',
                      usuarioData?['tipoUsuario']?.toString() ?? 'N/A'),
                ],
              ),
            ),
    );
  }

  // Widget para mostrar los detalles del perfil
  Widget _buildProfileDetail(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$label:'),
          Text(value),
        ],
      ),
    );
  }
}
