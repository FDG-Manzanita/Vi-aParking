import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:8080/api';

  // --- Estacionamiento ---
  static Future<List<Map<String, dynamic>>> obtenerEstacionamientos() async {
    final response = await http.get(Uri.parse('$baseUrl/estacionamientos'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Error al cargar los estacionamientos');
    }
  }

  static Future<Map<String, dynamic>> obtenerEstacionamientoPorId(
      int id) async {
    final response = await http.get(Uri.parse('$baseUrl/estacionamientos/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener el estacionamiento');
    }
  }

  static Future<void> crearEstacionamiento(
      Map<String, dynamic> estacionamientoData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/estacionamientos'),
      body: json.encode(estacionamientoData),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear el estacionamiento');
    }
  }

  static Future<void> actualizarEstacionamiento(
      int id, Map<String, dynamic> estacionamientoData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/estacionamientos/$id'),
      body: json.encode(estacionamientoData),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el estacionamiento');
    }
  }

  static Future<void> eliminarEstacionamiento(int id) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/estacionamientos/$id'));
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el estacionamiento');
    }
  }

  // --- Sector ---
  static Future<List<Map<String, dynamic>>> obtenerSectores() async {
    final response = await http.get(Uri.parse('$baseUrl/sectores'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Error al cargar los sectores');
    }
  }

  // --- Incidente ---
  static Future<List<Map<String, dynamic>>> obtenerIncidentes() async {
    final response = await http.get(Uri.parse('$baseUrl/incidentes'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Error al cargar los incidentes');
    }
  }

  static Future<Map<String, dynamic>> obtenerIncidentePorId(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/incidentes/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener el incidente');
    }
  }

  static Future<void> crearIncidente(Map<String, dynamic> incidenteData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/incidentes'),
      body: json.encode(incidenteData),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear el incidente');
    }
  }

  static Future<void> actualizarIncidente(
      int id, Map<String, dynamic> incidenteData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/incidentes/$id'),
      body: json.encode(incidenteData),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el incidente');
    }
  }

  static Future<void> eliminarIncidente(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/incidentes/$id'));
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el incidente');
    }
  }

  // --- Vehículo ---
  static Future<List<Map<String, dynamic>>> obtenerVehiculos() async {
    final response = await http.get(Uri.parse('$baseUrl/vehiculos'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Error al cargar los vehículos');
    }
  }

  static Future<Map<String, dynamic>> obtenerVehiculoPorId(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/vehiculos/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener el vehículo');
    }
  }

  static Future<void> crearVehiculo(Map<String, dynamic> vehiculoData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/vehiculos'),
      body: json.encode(vehiculoData),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear el vehículo');
    }
  }

  static Future<void> actualizarVehiculo(
      int id, Map<String, dynamic> vehiculoData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/vehiculos/$id'),
      body: json.encode(vehiculoData),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el vehículo');
    }
  }

  static Future<void> eliminarVehiculo(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/vehiculos/$id'));
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el vehículo');
    }
  }

  // --- Usuario ---
  static Future<List<Map<String, dynamic>>> obtenerUsuarios() async {
    final response = await http.get(Uri.parse('$baseUrl/usuarios'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Error al cargar los usuarios');
    }
  }

  static Future<Map<String, dynamic>> obtenerUsuarioPorId(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/usuarios/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener el usuario');
    }
  }

  static Future<void> crearUsuario(Map<String, dynamic> usuarioData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/usuarios'),
      body: json.encode(usuarioData),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear el usuario');
    }
  }

  static Future<void> actualizarUsuario(
      int id, Map<String, dynamic> usuarioData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/usuarios/$id'),
      body: json.encode(usuarioData),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el usuario');
    }
  }

  static Future<void> eliminarUsuario(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/usuarios/$id'));
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el usuario');
    }
  }

  // --- DetallePago ---
  static Future<List<Map<String, dynamic>>> obtenerDetallePagos() async {
    final response = await http.get(Uri.parse('$baseUrl/detalle-pagos'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Error al cargar los detalles de pago');
    }
  }

  static Future<Map<String, dynamic>> obtenerDetallePagoPorId(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/detalle-pagos/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener el detalle de pago');
    }
  }

  static Future<void> crearDetallePago(
      Map<String, dynamic> detallePagoData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/detalle-pagos'),
      body: json.encode(detallePagoData),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear el detalle de pago');
    }
  }

  static Future<void> actualizarDetallePago(
      int id, Map<String, dynamic> detallePagoData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/detalle-pagos/$id'),
      body: json.encode(detallePagoData),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el detalle de pago');
    }
  }

  static Future<void> eliminarDetallePago(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/detalle-pagos/$id'));
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el detalle de pago');
    }
  }

  // --- Pago ---
  static Future<List<Map<String, dynamic>>> obtenerPagos() async {
    final response = await http.get(Uri.parse('$baseUrl/pagos'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Error al cargar los pagos');
    }
  }

  static Future<Map<String, dynamic>> obtenerPagoPorId(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/pagos/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener el pago');
    }
  }

  static Future<void> crearPago(Map<String, dynamic> pagoData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/pagos'),
      body: json.encode(pagoData),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear el pago');
    }
  }

  static Future<void> actualizarPago(
      int id, Map<String, dynamic> pagoData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/pagos/$id'),
      body: json.encode(pagoData),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el pago');
    }
  }

  static Future<void> eliminarPago(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/pagos/$id'));
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el pago');
    }
  }

  // --- Tarifa ---
  static Future<List<Map<String, dynamic>>> obtenerTarifas() async {
    final response = await http.get(Uri.parse('$baseUrl/tarifas'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Error al cargar las tarifas');
    }
  }

  static Future<Map<String, dynamic>> obtenerTarifaPorId(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/tarifas/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener la tarifa');
    }
  }

  static Future<void> crearTarifa(Map<String, dynamic> tarifaData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tarifas'),
      body: json.encode(tarifaData),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear la tarifa');
    }
  }

  static Future<void> actualizarTarifa(
      int id, Map<String, dynamic> tarifaData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/tarifas/$id'),
      body: json.encode(tarifaData),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw Exception('Error al actualizar la tarifa');
    }
  }

  static Future<void> eliminarTarifa(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/tarifas/$id'));
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar la tarifa');
    }
  }
}
