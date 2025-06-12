import 'package:somativa_registro_plantas/db/databse_helper.dart';

import '../models/planta.dart';

class PlantaController {
  final dbHelper = DatabaseHelper.instance;

  Future<int> inserirPlanta(Planta planta) async {
    return await dbHelper.insert('plantas', planta.toMap());
  }

  Future<List<Planta>> listarPlantas() async {
    final List<Map<String, dynamic>> maps = await dbHelper.queryAllRows('plantas');
    return maps.map((map) => Planta.fromMap(map)).toList();
  }

  Future<Planta?> buscarPlantaPorId(int id) async {
    final List<Map<String, dynamic>> maps = await dbHelper.queryRows(
      'plantas',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Planta.fromMap(maps.first);
    }
    return null;
  }

  Future<int> atualizarPlanta(Planta planta) async {
    return await dbHelper.update(
      'plantas',
      planta.toMap(),
      'id = ?',
      [planta.id],
    );
  }

  Future<int> deletarPlanta(int id) async {
    return await dbHelper.delete('plantas', 'id = ?', [id]);
  }

  Future<void> adicionarPlanta({
    required String nome,
    required String especie,
    required String data,
    required String local, required fotoPath,
  }) async {
    final planta = Planta(
      nome: nome,
      especie: especie,
      dataAquisicao: data,
      local: local,
      fotoPath: null,
    );
    await inserirPlanta(planta);
  }
}