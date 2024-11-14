import 'dart:convert';
import 'package:app_estacionamientos_fiscalizador/screens/estacionamiento_screen.dart';
import 'package:app_estacionamientos_fiscalizador/screens/login_screen.dart';
import 'perfil.dart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Pantalla de sectores
class SectorScreen extends StatefulWidget {
  @override
  _SectorScreenState createState() => _SectorScreenState();
}

class _SectorScreenState extends State<SectorScreen> {
  List<dynamic> sectors = [];

  @override
  void initState() {
    super.initState();
    fetchSectors();
  }

  // Función para obtener los sectores desde la API
  Future<void> fetchSectors() async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/api/sectores'));

    if (response.statusCode == 200) {
      setState(() {
        sectors = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load sectors');
    }
  }

  // Función para manejar el cierre de sesión
  void logout() {
    // Redirige a la pantalla de login y reemplaza la ruta actual
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  // Función para navegar al perfil
  void goToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PerfilScreen()), // Navegar a PerfilScreen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sectores'),
        backgroundColor: Color(0xFF00B2E3), // Color de fondo del app bar
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration:
                  BoxDecoration(color: Color(0xFF00B2E3)), // Fondo del Drawer
              child: Text(
                'Menú',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Perfil'),
              onTap: () {
                Navigator.pop(context);
                goToProfile(); // Redirigir a la pantalla de perfil
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Cerrar sesión'),
              onTap: () {
                Navigator.pop(context);
                logout();
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF00B2E3), Colors.lightBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: sectors.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text(
                  sectors[index]['nombre'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  // Al presionar el sector, navegar a la pantalla de estacionamientos
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EstacionamientoScreen(
                          sectorId: sectors[index]['idSector']),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
