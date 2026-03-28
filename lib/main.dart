import 'package:bolao_/database/database_inicializer.dart';
import 'package:flutter/material.dart';
import 'package:bolao_/app_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseInitializer.inicializarBanco();
  runApp(const AppModule());
}
