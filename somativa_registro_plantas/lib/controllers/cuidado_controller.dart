import 'package:somativa_registro_plantas/db/databse_helper.dart';

import '../models/cuidado.dart';

class CuidadoController {
  final dbHelper = DatabaseHelper.instance;

  Future<int> inserirCuidado(Cuidado cuidado) async {
    return await dbHelper.insert('cuidados', cuidado.toMap());
  }

  Future<List<Cuidado>> listarCuidados() async {
    final List<Map<String, dynamic>> maps = await dbHelper.queryAllRows('cuidados');
    return maps.map((map) => Cuidado.fromMap(map)).toList();
  }

  Future<List<Cuidado>> listarCuidadosPorPlanta(int plantaId) async {
    final List<Map<String, dynamic>> maps = await dbHelper.queryRows(
      'cuidados',
      where: 'plantaId = ?',
      whereArgs: [plantaId],
    );
    return maps.map((map) => Cuidado.fromMap(map)).toList();
  }

  Future<int> deletarCuidado(int id) async {
    return await dbHelper.delete('cuidados', 'id = ?', [id]);
  }
}