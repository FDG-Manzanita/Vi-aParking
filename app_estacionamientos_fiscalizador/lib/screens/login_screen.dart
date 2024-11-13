import 'package:flutter/material.dart';
import 'sector_screen.dart'; // Importa la pantalla SectorScreen

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Campo de texto para correo electrónico
            TextField(
              decoration: InputDecoration(
                labelText: 'Correo Electrónico',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // Campo de texto para contraseña
            TextField(
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),

            // Botón de iniciar sesión
            ElevatedButton(
              onPressed: () {
                // Navegar a SectorScreen al presionar el botón
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SectorScreen()),
                );
              },
              child: Text('Iniciar Sesión'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
