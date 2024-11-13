import 'package:flutter/material.dart';
import 'sector_screen.dart'; // Importa la pantalla SectorScreen
import 'package:app_estacionamientos_fiscalizador/widgets/textfield_widget.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF00B2E3), Colors.lightBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.account_circle,
                  size: 100,
                  color: Colors.white,
                ),
                const SizedBox(height: 20),
                const Text(
                  '¡Bienvenido a la App!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                // Campo de texto para correo electrónico
                const TextFieldWidget(
                  hintText: 'Correo Electrónico',
                  obscureText: false,
                  prefixIconData: Icons.mail_outline,
                ),
                const SizedBox(height: 20),

                // Campo de texto para contraseña
                const TextFieldWidget(
                  hintText: 'Contraseña',
                  obscureText: true,
                  prefixIconData: Icons.lock_outline,
                  suffixIconData: Icons
                      .visibility_off, // Ícono de visibilidad para la contraseña
                ),
                const SizedBox(height: 30),

                // Botón de iniciar sesión
                _styledButton('Iniciar Sesión', () {
                  // Navegar a SectorScreen al presionar el botón
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SectorScreen()),
                  );
                }),

                const SizedBox(height: 20),
              ],
            ),
          ),
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
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
    );
  }
}
