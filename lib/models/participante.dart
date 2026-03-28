import 'dart:convert';

class Participante {
  final int? id;
  final String nome;
  final int pontuacao;
  final Map<String, List<int>> grupos;


  

  Participante({
    this.id,
    required this.nome,
    this.pontuacao = 0,
    required this.grupos,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'pontuacao': pontuacao,
      'grupos': jsonEncode(grupos)

    };
  }

  factory Participante.fromMap(Map<String, dynamic> map) {
    return Participante(
      id: map['id'],
      nome: map['nome'],
      pontuacao: map['pontuacao'] ?? 0,
      grupos: Map<String, List<int>>.from(
        jsonDecode(map['grupos']).map(
          (key, value) => MapEntry(key, List<int>.from(value)),
        )
      )
      );
  }
}