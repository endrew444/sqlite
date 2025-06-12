class Planta {
  int? id;
  String nome;
  String especie;
  String dataAquisicao;
  String local;
  String? fotoPath;

  Planta({
    this.id,
    required this.nome,
    required this.especie,
    required this.dataAquisicao,
    required this.local,
    this.fotoPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'especie': especie,
      'dataAquisicao': dataAquisicao,
      'local': local,
      'fotoPath': fotoPath,
    };
  }

  factory Planta.fromMap(Map<String, dynamic> map) {
    return Planta(
      id: map['id'],
      nome: map['nome'],
      especie: map['especie'],
      dataAquisicao: map['dataAquisicao'],
      local: map['local'],
      fotoPath: map['fotoPath'],
    );
  }
}
