import 'package:bolao_/data/times_data.dart';
import 'package:bolao_/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseInitializer {
  /// Popula a tabela de times se estiver vazia
  static Future<void> criarTimesExemplo() async {
    final db = await DatabaseHelper.instance.database;
    final count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM times'));
    if (count != null && count > 0) return;

    for (var time in timesData) {
      await db.insert('times', time.toMap());
    }

    final result = await db.query('times');
    print('Times no banco: $result');
  }

  /// Cria grupos se estiverem vazios
  static Future<void> criarGruposExemplo() async {
    final db = await DatabaseHelper.instance.database;
    final countGrupos = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM grupos'));
    if (countGrupos != null && countGrupos > 0) return;

    final grupos = [
      {'id': 1, 'nome': 'Grupo 1'},
      {'id': 2, 'nome': 'Grupo 2'},
      {'id': 3, 'nome': 'Grupo 3'},
      {'id': 4, 'nome': 'Grupo 4'},
      {'id': 5, 'nome': 'Grupo 5'},
      {'id': 6, 'nome': 'Grupo 6'},
    ];

    for (var grupo in grupos) {
      await db.insert('grupos', grupo);
    }
  }

  /// Inicializa tudo de uma vez
  static Future<void> inicializarBanco() async {
    await criarGruposExemplo();
    await criarTimesExemplo();
  }
}