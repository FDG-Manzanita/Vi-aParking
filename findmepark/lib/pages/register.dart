import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isResidenteSelected = true;
  bool _isTuristaSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
        backgroundColor:
            const Color(0xFF00B2E3), // Color principal en Pantone 00B2E3
      ),
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
                  Icons.person_add,
                  size: 100,
                  color: Colors.white,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Crea tu cuenta',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  '¿Usted es residente o turista?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                // Botones para seleccionar tipo de usuario
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isResidenteSelected
                            ? null
                            : () {
                                setState(() {
                                  _isResidenteSelected = true;
                                  _isTuristaSelected = false;
                                });
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _isResidenteSelected ? Colors.grey : Colors.white,
                          foregroundColor: Colors.black, // Color del texto
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Residente',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isTuristaSelected
                            ? null
                            : () {
                                setState(() {
                                  _isResidenteSelected = false;
                                  _isTuristaSelected = true;
                                });
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _isTuristaSelected ? Colors.grey : Colors.white,
                          foregroundColor: Colors.black, // Color del texto
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Turista',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                _buildTextField('Nombre Completo', Icons.person),
                const SizedBox(height: 20),
                _buildTextField('Email', Icons.mail_outline),
                const SizedBox(height: 20),
                _buildTextField('Contraseña', Icons.lock_outline,
                    obscureText: true),
                const SizedBox(height: 20),
                _buildTextField('Confirmar Contraseña', Icons.lock_outline,
                    obscureText: true),
                const SizedBox(height: 20),
                if (_isResidenteSelected) ...[
                  _buildTextField('Ingresar RUT', Icons.credit_card),
                  const SizedBox(height: 20),
                  _buildTextField('Ingresar Residencia', Icons.home),
                ] else if (_isTuristaSelected) ...[
                  _buildTextField('Nro. de Pasaporte', Icons.credit_card),
                ],
                const SizedBox(height: 20),
                _buildTextField('Número de Teléfono', Icons.phone),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    // Acción de registro (no funcional en este caso)
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, // Color del texto
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Registrar',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Volver al inicio de sesión',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, IconData icon,
      {bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon, color: const Color(0xFF00B2E3)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
