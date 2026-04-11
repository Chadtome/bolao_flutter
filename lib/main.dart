import 'package:bolao_/database/database_inicializer.dart';
import 'package:bolao_/data/times_data.dart';
import 'package:bolao_/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:bolao_/app_module.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseInitializer.inicializarBanco();

  // Popula times de exemplo
  await criarTimesExemplo();

  runApp(const AppModule());
}

//-------------------

// Widget principal do app
class BolaoApp extends StatelessWidget {
  const BolaoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: TimesScreen(),
      home: Scaffold(
        body: Center(
          child: Text('Bolão App - Banco testado!'),
        ),
      ),
    );
  }
}

//-------------------

// Função para popular times
Future<void> criarTimesExemplo() async {
  final db = await DatabaseHelper.instance.database;

  final count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM times'));

  print('Quantidade de times no banco: ${count}');

  if (count! > 0) return;

  for (var time in timesData) {
    await db.insert('times', time.toMap());
  }

  final result = await db.query('times');
  print('Times no banco: ${result}');
}
