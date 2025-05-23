//CLASSES MODELOS -> CONECTAR COM AS ENTIDADES DO BD

class Pet{
  final int? id; //permite ser nulo
  final String nome; //final so permite trocar 1 unica vez// const nao muda nenhuma vez
  final String raca;
  final String nomeDono;
  final String telefoneDono;

  Pet({
    this.id,
    required this.nome,
    required this.raca,
    required this.nomeDono,
    required this.telefoneDono,
  });
  //méodos de conversão ->  obj -> BD : BD -> obj

  Map<String,dynamic> toMap(){
    return{
      "id": id,
      "name": nome,
      "raca": raca,
      "nome_dono": nomeDono, 
      "telefone_dono": telefoneDono,
    };
  }

  factory Pet.fromMap(Map<String,dynamic> map){
    return Pet(
      id: map["id"] as int,
      nome: map["name"] as String,
      raca: map["raca"] as String,
      nomeDono: map["nome_dono"] as String,
      telefoneDono: map["telefone_dono"] as String,
    );
  }

}