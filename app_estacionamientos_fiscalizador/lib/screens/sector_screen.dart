import 'dart:convert';
import 'package:app_estacionamientos_fiscalizador/screens/estacionamiento_screen.dart';
import 'package:app_estacionamientos_fiscalizador/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    Navigator.of(context).pushNamed('/profile');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sectores')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
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
                goToProfile();
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
      body: ListView.builder(
        itemCount: sectors.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(sectors[index]['nombre']),
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
          );
        },
      ),
    );
  }
}
