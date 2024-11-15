import 'package:flutter/material.dart';

///import 'package:http/http.dart' as http;

class AgregarDetallePagoScreen extends StatelessWidget {
  final int vehiculoId;

  AgregarDetallePagoScreen({required this.vehiculoId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agregar Pago',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF00B2E3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Agregar pago para el vehículo con ID: $vehiculoId',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Aquí puedes agregar la lógica para procesar el pago en efectivo
                  print("Pago en efectivo para el vehículo $vehiculoId");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00B2E3),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Pago en Efectivo',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Aquí puedes agregar la lógica para procesar el pago con tarjeta
                  print("Pago con tarjeta para el vehículo $vehiculoId");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00B2E3),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Pago con Tarjeta',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
