//import 'dart:convert';
import 'package:bolao_/models/resultado.dart';
import 'package:bolao_/models/time.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/participante.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('bolao.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  //------------------- Criação das tabelas -------------------
  Future _createDB(Database db, int version) async {
    // Tabela de grupos
    await db.execute('''
      CREATE TABLE grupos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL
      )
    ''');

    // Tabela de times
    await db.execute('''
      CREATE TABLE times(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        logo TEXT,
        grupo_id INTEGER,
        abreviatura TEXT,
        FOREIGN KEY (grupo_id) REFERENCES grupos(id)
      )
    ''');

    // Tabela de participantes
    await db.execute('''
      CREATE TABLE participantes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        pontuacao INTEGER NOT NULL,
        grupos TEXT NOT NULL
      )
    ''');

    // Tabela de resultados
    await db.execute('''
      CREATE TABLE resultados(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        rodada INTEGER NOT NULL,
        timeA TEXT NOT NULL,
        timeB TEXT NOT NULL,
        golsA INTEGER,
        golsB INTEGER
      )
''');
  }

  //------------------- Métodos para Grupos -------------------
  Future<List<Map<String, dynamic>>> buscarGrupos() async {
    final db = await instance.database;
    final grupos = await db.query('grupos', orderBy: 'id');
    return grupos;
  }

  Future<List<Map<String, dynamic>>> buscarTimesPorGrupo(int grupoId) async {
    final db = await instance.database;
    final times = await db.query(
      'times',
      where: 'grupo_id = ?',
      whereArgs: [grupoId],
      orderBy: 'id',
    );
    return times;
  }

  //------------------- Métodos para Participantes -------------------
  
  // Inserir participante
  Future<int> inserirParticipante(Participante participante) async {
    final db = await instance.database;
    return await db.insert(
      'participantes',
      participante.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Buscar todos os participantes
  Future<List<Participante>> buscarParticipantes() async {
    final db = await instance.database;
    final result = await db.query('participantes', orderBy: 'id');
    return result.map((map) => Participante.fromMap(map)).toList();
  }

  // Buscar participante por ID
  Future<Participante?> buscarParticipantePorId(int id) async {
    final db = await instance.database;
    final result =
        await db.query('participantes', where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return Participante.fromMap(result.first);
    }
    return null;
  }

  // Atualizar participante
  Future<int> atualizarParticipante(Participante participante) async {
    final db = await instance.database;
    return await db.update(
      'participantes',
      participante.toMap(),
      where: 'id = ?',
      whereArgs: [participante.id],
    );
  }

  // Deletar participante
  Future<int> deletarParticipante(int id) async {
    final db = await instance.database;
    return await db.delete(
      'participantes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Inserir resultados
  Future<int> inserirResultados(Resultado resultado) async {
    final db = await instance.database;
    return await db.insert(
      'resultados',
      resultado.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, // evita duplicados
    );
  }

  // Buscar resultados por rodada
  Future<List<Resultado>> buscarResultadosPorRodada(int rodada) async {
    final db = await instance.database;
    final result = await db.query(
      'resultados',
      where: 'rodada = ?',
      whereArgs: [rodada],
    );
    return result.map((map) => Resultado.fromMap(map)).toList();
  }

  // Atualizar resultado
  Future<int> atualizarResultado(Resultado resultado) async {
    final db = await instance.database;
    return await db.update(
      'resultados',
      resultado.toMap(),
      where: 'id = ?',
      whereArgs: [resultado.id]
    );
  }

  // Deletar resultado
  Future<int> deletarResultado(int id) async {
    final db = await instance.database;
    return await db.delete(
      'resultados',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Buscar todos os times
Future<List<Time>> buscarTodosOsTimes() async {
  final db = await instance.database;
  final result = await db.query('times', orderBy: 'nome');
  return result.map((map) => Time.fromMap(map)).toList();
}

// Buscar todos os resultados (de todas as rodadas)
Future<List<Resultado>> buscarTodosOsResultados() async {
  final db = await instance.database;
  final result = await db.query('resultados');
  return result.map((map) => Resultado.fromMap(map)).toList();
}
}

