import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AgregarDetallePagoScreen extends StatelessWidget {
  final int vehiculoId;

  AgregarDetallePagoScreen({required this.vehiculoId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agregar Pago')),
      body: Center(
        child: Text('Agregar pago para el vehículo con ID: $vehiculoId'),
      ),
    );
  }
}
