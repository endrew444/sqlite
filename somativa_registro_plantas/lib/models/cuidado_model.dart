class Cuidado {
  int? id;
  int plantaId; // FK para planta
  String tipo; // rega, adubação, poda
  DateTime data;
  String? observacoes;

  Cuidado({
    this.id,
    required this.plantaId,
    required this.tipo,
    required this.data,
    this.observacoes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'plantaId': plantaId,
      'tipo': tipo,
      'data': data.toIso8601String(),
      'observacoes': observacoes,
    };
  }

  factory Cuidado.fromMap(Map<String, dynamic> map) {
    return Cuidado(
      id: map['id'],
      plantaId: map['plantaId'],
      tipo: map['tipo'],
      data: DateTime.parse(map['data']),
      observacoes: map['observacoes'],
    );
  }
}
