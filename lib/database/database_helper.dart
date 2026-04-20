import 'package:bolao_/models/resultado.dart';
import 'package:bolao_/models/time.dart';
import 'package:bolao_/models/usuario.dart';
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

    // Tabela de usuários
    await db.execute('''
      CREATE TABLE usuarios(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      login TEXT UNIQUE NOT NULL,
      senha TEXT NOT NULL,
      tipo TEXT NOT NULL,
      participante_id INTEGER,
      FOREIGN KEY (participante_id) REFERENCES participantes(id)
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
  
  // Inserir participante e criar usuário automaticamente
  Future<int> inserirParticipanteComUsuario(Participante participante, String senha) async {
    final db = await database;
    
    // Inserir participante
    final participanteId = await db.insert('participantes', participante.toMap());
    
    // Criar usuário para o participante
    final usuario = {
      'login': participante.nome.toLowerCase().replaceAll(' ', '_'),
      'senha': senha,
      'tipo': 'user',
      'participante_id': participanteId,
    };
    
    await db.insert('usuarios', usuario);
    
    return participanteId;
  }

  // Inserir participante (sem usuário) - para admin/testes
  Future<int> inserirParticipante(Participante participante) async {
    final db = await instance.database;
    return await db.insert(
      'participantes',
      participante.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Inserir participante e vincular ao usuário existente
  Future<int> inserirParticipanteParaUsuario(Participante participante, int usuarioId) async {
    final db = await database;
    
    // Inserir participante
    final participanteId = await db.insert('participantes', participante.toMap());
    
    // Atualizar usuário com o participante_id
    await db.update(
      'usuarios',
      {'participante_id': participanteId},
      where: 'id = ?',
      whereArgs: [usuarioId],
    );
    
    print('✅ Participante vinculado ao usuário ID $usuarioId');
    
    return participanteId;
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

  // Deletar participante e desvincular do usuário
  Future<int> deletarParticipante(int id) async {
    final db = await database;
    
    // Buscar usuários que têm este participante_id
    final usuarios = await db.query(
      'usuarios',
      where: 'participante_id = ?',
      whereArgs: [id],
    );
    
    // Desvincular o participante dos usuários
    for (var usuario in usuarios) {
      await db.update(
        'usuarios',
        {'participante_id': null},
        where: 'id = ?',
        whereArgs: [usuario['id']],
      );
      print('✅ Usuário ${usuario['login']} desvinculado do participante ID $id');
    }
    
    // Deletar o participante
    final result = await db.delete(
      'participantes',
      where: 'id = ?',
      whereArgs: [id],
    );
    
    print('✅ Participante ID $id deletado');
    
    return result;
  }

  // Inserir resultados
  Future<int> inserirResultados(Resultado resultado) async {
    final db = await database;
    return await db.insert(
      'resultados',
      resultado.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
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

  // Inserir ADMIN padrão
  Future<void> inserirAdminPadrao() async {
    final db = await database;

    final result = await db.query(
      'usuarios',
      where: 'tipo = ?',
      whereArgs: ['admin'],
    );

    if (result.isEmpty) {
      await db.insert('usuarios', {
        'login': 'admin',
        'senha': 'admin123',
        'tipo': 'admin',
        'participante_id': null,
      });
      print('✅ Usuário admin criado: login=admin, senha=admin123');
    }
  }

  // Buscar usuário por login e senha
  Future<Map<String, dynamic>?> buscarUsuario(String login, String senha) async {
    final db = await database;
    final result = await db.query(
      'usuarios',
      where: 'login = ? AND senha = ?',
      whereArgs: [login, senha],
    );
    
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  // Criar apenas usuário (sem participante vinculado)
  Future<void> criarUsuario(String login, String senha) async {
    final db = await database;
    
    // Verificar se login já existe
    final existing = await db.query(
      'usuarios',
      where: 'login = ?',
      whereArgs: [login],
    );
    
    if (existing.isNotEmpty) {
      throw Exception('Login já existe');
    }
    
    final usuario = {
      'login': login,
      'senha': senha,
      'tipo': 'user',
      'participante_id': null,
    };
    
    await db.insert('usuarios', usuario);
    print('✅ Usuário criado: login=$login, senha=$senha');
  }

  // Buscar usuário por ID
  Future<Usuario> buscarUsuarioPorId(int id) async {
    final db = await database;
    final result = await db.query(
      'usuarios',
      where: 'id = ?',
      whereArgs: [id],
    );
    
    if (result.isNotEmpty) {
      return Usuario.fromMap(result.first);
    }
    throw Exception('Usuário não encontrado');
  }

  // Alterar senha do usuário
  Future<void> alterarSenha(int usuarioId, String novaSenha) async {
    final db = await database;
    
    await db.update(
      'usuarios',
      {'senha': novaSenha},
      where: 'id = ?',
      whereArgs: [usuarioId],
    );
    
    print('✅ Senha alterada para usuário ID $usuarioId');
  }
}