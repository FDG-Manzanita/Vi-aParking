import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // Para guardar el id_usuario
import 'package:app_estacionamientos_fiscalizador/screens/sector_screen.dart';

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
    final String baseUrl = 'http://localhost:8080/api/usuarios/login';

    try {
      // Llamada a la API con los datos del login
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
        final data = json.decode(response.body);

        // Verificamos que la respuesta tenga el `id_usuario`
        if (data.containsKey('id_usuario')) {
          final int idUsuario = data['id_usuario'];

          // Guardar idUsuario usando SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setInt('id_usuario', idUsuario);

          // Navegar a la pantalla de Sectores
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SectorScreen()),
          );
        } else {
          // Si no se recibe el `id_usuario`, mostrar error
          _showErrorDialog('Error al obtener la información del usuario');
        }
      } else {
        // Si el login falla (credenciales incorrectas)
        _showErrorDialog('Credenciales inválidas o usuario no autorizado');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Error de conexión o problema de red
      _showErrorDialog('Error de conexión, por favor intente nuevamente');
    }
  }

  // Mostrar un diálogo de error
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
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
                _styledButton('Ingresar', _login),
                const SizedBox(height: 20),
                if (_isLoading) const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Método para construir campos de texto
  Widget _buildTextField(String hintText, bool obscureText,
      TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black), // Hints en negro
        prefixIcon: Icon(icon, color: Colors.black), // Icono en negro
        filled: true,
        fillColor: Colors.white, // Fondo blanco
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.black), // Texto en negro
    );
  }

  // Método para construir el botón de ingresar
  Widget _styledButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
