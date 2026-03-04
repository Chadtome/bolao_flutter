class Participante {
  final int? id;
  final String nome;
  final int pontuacao;

  Participante({
    this.id,
    required this.nome,
    this.pontuacao = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'pontuacao': pontuacao,

    };
  }

  factory Participante.fromMap(Map<String, dynamic> map) {
    return Participante(
      id: map['id'],
      nome: map['nome'],
      pontuacao: map['pontuacao'],
      );
  }
}