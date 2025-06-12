class Cuidado {
  final int? id;
  final int plantaId;
  final String tipo;
  final DateTime data;
  final String? observacoes;

  Cuidado({
    this.id,
    required this.plantaId,
    required this.tipo,
    required this.data,
    this.observacoes,
  });

  factory Cuidado.fromMap(Map<String, dynamic> map) {
    return Cuidado(
      id: map['id'],
      plantaId: map['plantaId'],
      tipo: map['tipo'],
      data: DateTime.parse(map['data']),
      observacoes: map['observacoes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'plantaId': plantaId,
      'tipo': tipo,
      'data': data.toIso8601String(),
      'observacoes': observacoes,
    };
  }
}