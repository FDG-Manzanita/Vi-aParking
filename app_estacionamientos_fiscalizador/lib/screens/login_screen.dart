import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_estacionamientos_fiscalizador/screens/sector_screen.dart'; // Asegúrate de crear esta pantalla

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  // Función de login que realiza la llamada a la API
  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    final String email = _emailController.text;
    final String password = _passwordController.text;

    // URL de la API (asegúrate de cambiar esto a la correcta)
    final String baseUrl = 'http://localhost:8080/api/usuarios/login';

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        body: {
          'email': email,
          'contraseña': password,
        },
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        // Si el login es exitoso, redirige a SectoresScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SectorScreen()),
        );
      } else {
        // Si el login falla (credenciales incorrectas o usuario no autorizado)
        _showErrorDialog('Credenciales inválidas o usuario no autorizado');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // En caso de error de red o problemas con la solicitud
      _showErrorDialog('Error de conexión, por favor intente nuevamente');
    }
  }

  // Mostrar un diálogo de error
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

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
                  '¡Bienvenido a FindMePark!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                _buildTextField(
                    'Email', false, _emailController, Icons.mail_outline),
                const SizedBox(height: 20),
                _buildTextField('Contraseña', true, _passwordController,
                    Icons.lock_outline),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _styledButton('Ingresar', _login),
                    const SizedBox(width: 10),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, bool obscureText,
      TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        prefixIcon: Icon(icon, color: Colors.white),
        filled: true,
        fillColor: Colors.transparent,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }

  Widget _styledButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: Colors.white, // Fondo blanco
        foregroundColor: Colors.black, // Texto negro
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
