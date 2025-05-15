class Nota{
  //atributos
  int? id; //permite nula em um primeiro momento (banco de dados vai fornecer o id)
  String titulo;
  String conteudo;

  //construtor
  Nota({this.id, required this.titulo, required this.conteudo}); 

  //métodos

  // converter obj <=> Banco de Dados

  //toMap : Obj => BD

  Map<String,dynamic> toMap() =>
    {
      "id":id,
      "titulo":titulo,
      "conteudo":conteudo
    };
  //CONVERTER UM OBJ DA CLASSE NOTA PARA UM MAP(REFERENCIADO NO BANCO DE DADOS)
  
  //fromMap : Bd -> Obj
  factory Nota.fromMap(Map<String,dynamic> map)=> Nota(
    id: map["id"] as int,
    titulo: map['titulo'] as String, 
    conteudo: map["conteudo"] as String);

    @override
    String toString() {
      return 'Nota{id: $id, titulo: $titulo, conteudo: $conteudo}';
    }

}