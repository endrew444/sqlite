// ignore: depend_on_referenced_packages
import 'package:somativa_registro_plantas/models/cuidado.dart';
import 'package:somativa_registro_plantas/models/planta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('jardim_virtual.db');
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

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE plantas(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        especie TEXT NOT NULL,
        dataAquisicao TEXT NOT NULL,
        local TEXT NOT NULL,
        fotoPath TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE cuidados(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        plantaId INTEGER NOT NULL,
        tipo TEXT NOT NULL,
        data TEXT NOT NULL,
        observacoes TEXT,
        FOREIGN KEY (plantaId) REFERENCES plantas (id) ON DELETE CASCADE
      )
    ''');
  }

  // CRUD Planta
  Future<int> insertPlanta(Planta planta) async {
    final db = await instance.database;
    return await db.insert('plantas', planta.toMap());
  }

  Future<List<Planta>> getPlantas() async {
    final db = await instance.database;
    final result = await db.query('plantas');
    return result.map((json) => Planta.fromMap(json)).toList();
  }

  Future<int> updatePlanta(Planta planta) async {
    final db = await instance.database;
    return await db.update(
      'plantas',
      planta.toMap(),
      where: 'id = ?',
      whereArgs: [planta.id],
    );
  }

  Future<int> deletePlanta(int id) async {
    final db = await instance.database;
    return await db.delete(
      'plantas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // CRUD Cuidado
  Future<int> insertCuidado(Cuidado cuidado) async {
    final db = await instance.database;
    return await db.insert('cuidados', cuidado.toMap());
  }

  Future<List<Cuidado>> getCuidadosByPlanta(int plantaId) async {
    final db = await instance.database;
    final result = await db.query(
      'cuidados',
      where: 'plantaId = ?',
      whereArgs: [plantaId],
      orderBy: 'data DESC',
    );
    return result.map((json) => Cuidado.fromMap(json)).toList();
  }

  Future<int> updateCuidado(Cuidado cuidado) async {
    final db = await instance.database;
    return await db.update(
      'cuidados',
      cuidado.toMap(),
      where: 'id = ?',
      whereArgs: [cuidado.id],
    );
  }

  Future<int> deleteCuidado(int id) async {
    final db = await instance.database;
    return await db.delete(
      'cuidados',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
  Future<void> clearDatabase() async {
    final db = await instance.database;
    await db.delete('plantas');
    await db.delete('cuidados');
  }

  Future<int> getPlantaCount() async {
    final db = await instance.database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM plantas');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<int> getCuidadoCount() async {
    final db = await instance.database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM cuidados');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<List<Map<String, dynamic>>> getAllRows(String table) async {
    final db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryRows(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
    String? orderBy,
  }) async {
    final db = await instance.database;
    return await db.query(
      table,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
    );
  }

  Future<int> insert(String table, Map<String, dynamic> map) async {
    final db = await instance.database;
    return await db.insert(table, map);
  }

  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    final db = await instance.database;
    return await db.query(table);
  }

  Future<int> update(String table, Map<String, dynamic> map, String where, List<dynamic> whereArgs) async {
    final db = await instance.database;
    return await db.update(
      table,
      map,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<int> delete(String table, String where, List<dynamic> whereArgs) async {
    final db = await instance.database;
    return await db.delete(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }
}
