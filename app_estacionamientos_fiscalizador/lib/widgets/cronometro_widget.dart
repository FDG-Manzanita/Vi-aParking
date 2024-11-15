import 'dart:async';
import 'package:flutter/material.dart';

class CronometroWidget extends StatefulWidget {
  final DateTime tiempoInicio;

  CronometroWidget({required this.tiempoInicio});

  @override
  _CronometroWidgetState createState() => _CronometroWidgetState();
}

class _CronometroWidgetState extends State<CronometroWidget> {
  late Timer _timer;
  late Duration _tiempoTranscurrido;

  @override
  void initState() {
    super.initState();
    _tiempoTranscurrido = DateTime.now().difference(widget.tiempoInicio);
    _timer = Timer.periodic(Duration(seconds: 1), _actualizarTiempo);
  }

  void _actualizarTiempo(Timer timer) {
    setState(() {
      _tiempoTranscurrido = DateTime.now().difference(widget.tiempoInicio);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int segundos = _tiempoTranscurrido.inSeconds;
    int minutos = segundos ~/ 60;
    int horas = minutos ~/ 60;
    minutos = minutos % 60;
    segundos = segundos % 60;

    return Text(
      '$horas:${minutos.toString().padLeft(2, '0')}:${segundos.toString().padLeft(2, '0')}',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
