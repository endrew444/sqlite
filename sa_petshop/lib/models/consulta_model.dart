import 'package:intl/intl.dart';

class Consulta {
  //atributos
  final int? id;
  final int petId;
  final DateTime dataHora;//obj é dateTime -> BD é string
  final String tipoServico;
  final String? observacao;

  //construtor
  //final -> não pode ser alterado depois de atribuído
  Consulta({
    this.id,
    required this.petId,
    required this.dataHora,
    required this.tipoServico,
    this.observacao,
  });

  //toMap -> objeto -> BD
  Map<String,dynamic> toMap(){
    return{
      "id": id,
      "pet_id": petId,
      "data_hora": dataHora.toIso8601String(), //converte para string
      "tipo_servico": tipoServico,
      "observacao": observacao,
    };
  }

  //fromMap -> BD -> objeto
 factory Consulta.fromMap(Map<String,dynamic> map){
    return Consulta(
      id: map["id"] as int, //cast
      petId: map["pet_id"] as int, 
      dataHora: DateTime.parse(map["data_hora"] as String), //converter String em Formato de DateTime
      tipoServico: map["tipo_servico"] as String,
      observacao: map["observacao"] as String?,);// pode ser nulo
  }

  //formata a data para o formato Brasil
  String get dataHoraFormatada{
    final DateFormat formatter = DateFormat("dd/MM/yyyy HH:mm");
    return formatter.format(dataHora);
  }
}