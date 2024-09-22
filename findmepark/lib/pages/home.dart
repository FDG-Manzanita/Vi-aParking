import 'package:findmepark/pages/mapa.dart';
import 'package:flutter/material.dart';
import 'package:findmepark/pages/perfil.dart';
import 'package:findmepark/pages/myapp.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido'),
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
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar Sesión'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyLogin()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: '¿Dónde te diriges?',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapPage()),
                );
                // Acción al presionar el botón "Encontrar Estacionamiento"
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, // Color del texto
                backgroundColor: const Color(0xFF00B2E3),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Encontrar Estacionamiento',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 20), // Espacio entre los botones
            const Text(
              '¿Ya está estacionado?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10), // Espacio entre el texto y el botón
            ElevatedButton(
              onPressed: () {
                // Acción al presionar el botón "Registrar Patente"
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, // Color del texto
                backgroundColor: const Color(0xFF00B2E3),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Registre su patente',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            const Spacer(), // Ocupa el espacio restante para que el botón final quede al fondo
            ElevatedButton(
              onPressed: () {
                // Acción al presionar el botón "Solicitar Ayuda"
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, // Color del texto
                backgroundColor: Colors.red, // Cambiar color si lo deseas
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Solicitar Ayuda',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
