class Planta {
  int? id;
  String nome;
  String especie;
  DateTime dataAquisicao;
  String local;
  String? fotoPath; // caminho local da foto ou base64

  Planta({
    this.id,
    required this.nome,
    required this.especie,
    required this.dataAquisicao,
    required this.local,
    this.fotoPath,
  });

  // Convertendo para Map para salvar no banco
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'especie': especie,
      'dataAquisicao': dataAquisicao.toIso8601String(),
      'local': local,
      'fotoPath': fotoPath,
    };
  }

  // Criando objeto a partir do Map
  factory Planta.fromMap(Map<String, dynamic> map) {
    return Planta(
      id: map['id'],
      nome: map['nome'],
      especie: map['especie'],
      dataAquisicao: DateTime.parse(map['dataAquisicao']),
      local: map['local'],
      fotoPath: map['fotoPath'],
    );
  }
}
