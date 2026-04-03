import 'package:flutter/material.dart';

class Jogo {
  final String timeA;
  final String timeB;
  final String escudoA;
  final String escudoB;
  int? golsA;
  int? golsB;

  late TextEditingController controllerA;
  late TextEditingController controllerB;

  Jogo({
    required this.timeA,
    required this.timeB,
    required this.escudoA,
    required this.escudoB,
    this.golsA,
    this.golsB,
  }) {
    controllerA = TextEditingController(text: golsA?.toString() ?? '');
    controllerB = TextEditingController(text: golsB?.toString() ?? '');
    
  }
}