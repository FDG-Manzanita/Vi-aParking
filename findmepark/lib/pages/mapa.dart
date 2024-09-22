import 'package:findmepark/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:findmepark/pages/perfil.dart';
import 'package:findmepark/pages/myapp.dart'; // Asegúrate de que este archivo existe y está correctamente importado

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
        backgroundColor:
            const Color(0xFF00B2E3), // Color principal en Pantone 00B2E3
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF00B2E3),
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Ajustes'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
              },
            ),
            const Divider(), // Divider para separar el logout del resto
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar Sesión'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const MyLogin()), // Cambiar a la página de login cuando esté disponible
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text(
          'Aquí va el contenido del mapa.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
