import 'package:app_estacionamientos_fiscalizador/services/api_service.dart';
import 'package:flutter/material.dart';

class SectoresScreen extends StatefulWidget {
  @override
  _SectoresScreenState createState() => _SectoresScreenState();
}

class _SectoresScreenState extends State<SectoresScreen> {
  // Listas para almacenar los datos de las tablas
  List<Map<String, dynamic>> sectores = [];
  List<Map<String, dynamic>> estacionamientos = [];
  List<Map<String, dynamic>> incidentes = [];
  List<Map<String, dynamic>> vehiculos = [];
  List<Map<String, dynamic>> usuarios = [];
  List<Map<String, dynamic>> detallePagos = [];
  List<Map<String, dynamic>> pagos = [];
  List<Map<String, dynamic>> tarifas = [];

  // Variables para controlar los estados de carga
  bool isLoadingSectores = true;
  bool isLoadingEstacionamientos = true;
  bool isLoadingIncidentes = true;
  bool isLoadingVehiculos = true;
  bool isLoadingUsuarios = true;
  bool isLoadingDetallePagos = true;
  bool isLoadingPagos = true;
  bool isLoadingTarifas = true;

  @override
  void initState() {
    super.initState();
    cargarDatos(); // Cargar todos los datos cuando se inicializa el widget
  }

  // Método para cargar todos los datos
  void cargarDatos() async {
    try {
      // Obtener todos los datos de las tablas
      var sectoresResult = await ApiService.obtenerSectores();
      var estacionamientosResult = await ApiService.obtenerEstacionamientos();
      var incidentesResult = await ApiService.obtenerIncidentes();
      var vehiculosResult = await ApiService.obtenerVehiculos();
      var usuariosResult = await ApiService.obtenerUsuarios();
      var detallePagosResult = await ApiService.obtenerDetallePagos();
      var pagosResult = await ApiService.obtenerPagos();
      var tarifasResult = await ApiService.obtenerTarifas();

      setState(() {
        sectores = sectoresResult;
        estacionamientos = estacionamientosResult;
        incidentes = incidentesResult;
        vehiculos = vehiculosResult;
        usuarios = usuariosResult;
        detallePagos = detallePagosResult;
        pagos = pagosResult;
        tarifas = tarifasResult;

        // Actualizar los estados de carga
        isLoadingSectores = false;
        isLoadingEstacionamientos = false;
        isLoadingIncidentes = false;
        isLoadingVehiculos = false;
        isLoadingUsuarios = false;
        isLoadingDetallePagos = false;
        isLoadingPagos = false;
        isLoadingTarifas = false;
      });
    } catch (e) {
      setState(() {
        // Actualizar los estados de carga si hay un error
        isLoadingSectores = false;
        isLoadingEstacionamientos = false;
        isLoadingIncidentes = false;
        isLoadingVehiculos = false;
        isLoadingUsuarios = false;
        isLoadingDetallePagos = false;
        isLoadingPagos = false;
        isLoadingTarifas = false;
      });
      print("Error al cargar los datos: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Datos de Sectores, Estacionamientos, Incidentes, Vehículos, Usuarios, Pagos y Tarifas'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Sectores
            isLoadingSectores
                ? Center(child: CircularProgressIndicator())
                : _buildDataSection('Sectores', sectores),

            // Estacionamientos
            isLoadingEstacionamientos
                ? Center(child: CircularProgressIndicator())
                : _buildDataSection('Estacionamientos', estacionamientos),

            // Incidentes
            isLoadingIncidentes
                ? Center(child: CircularProgressIndicator())
                : _buildDataSection('Incidentes', incidentes,
                    isIncidente: true),

            // Vehículos
            isLoadingVehiculos
                ? Center(child: CircularProgressIndicator())
                : _buildDataSection('Vehículos', vehiculos),

            // Usuarios
            isLoadingUsuarios
                ? Center(child: CircularProgressIndicator())
                : _buildDataSection('Usuarios', usuarios),

            // Detalle Pagos
            isLoadingDetallePagos
                ? Center(child: CircularProgressIndicator())
                : _buildDataSection('Detalle de Pagos', detallePagos,
                    isDetallePago: true),

            // Pagos
            isLoadingPagos
                ? Center(child: CircularProgressIndicator())
                : _buildDataSection('Pagos', pagos, isPago: true),

            // Tarifas
            isLoadingTarifas
                ? Center(child: CircularProgressIndicator())
                : _buildDataSection('Tarifas', tarifas, isTarifa: true),
          ],
        ),
      ),
    );
  }

  // Método auxiliar para construir cada sección de datos
  Widget _buildDataSection(String title, List<Map<String, dynamic>> data,
      {bool isIncidente = false,
      bool isDetallePago = false,
      bool isPago = false,
      bool isTarifa = false}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            var item = data[index];
            return ListTile(
              title: Text(item['nombre'] ?? item['tipo'] ?? 'Sin tipo'),
              subtitle: _buildSubtitle(
                  item, isIncidente, isDetallePago, isPago, isTarifa),
              onTap: () {
                print('$title seleccionado: ${item['nombre'] ?? item['tipo']}');
              },
            );
          },
        ),
      ],
    );
  }

  // Método para manejar los diferentes tipos de subtítulos
  Widget _buildSubtitle(Map<String, dynamic> item, bool isIncidente,
      bool isDetallePago, bool isPago, bool isTarifa) {
    if (isIncidente) {
      return Text('Tipo: ${item['tipo']}');
    } else if (isDetallePago) {
      return Text('Total: ${item['total'] ?? 'Sin total'}');
    } else if (isPago) {
      return Text('Tiempo total: ${item['tiempoTotal'] ?? 'Sin tiempo'}');
    } else if (isTarifa) {
      return Text('Precio: ${item['precio'] ?? 'Sin precio'}');
    } else if (item.containsKey('cuposDisponibles')) {
      return Text('Cupos disponibles: ${item['cuposDisponibles']}');
    } else if (item.containsKey('vehiculo')) {
      return Text('Placa: ${item['vehiculo']}');
    } else {
      return Text('Sin detalles');
    }
  }
}
