class Usuario {
  final int? id;
  final String login;
  final String senha;
  final String tipo;
  final int? participanteId;

  Usuario({
    this.id,
    required this.login,
    required this.senha,
    required this.tipo,
    this.participanteId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'login': login,
      'senha': senha,
      'tipo': tipo,
      'participante_id': participanteId,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'],
      login: map['login'],
      senha: map['senha'],
      tipo: map['tipo'],
      participanteId: map['participante_id'],
    );
  }

  bool get isAdmin => tipo == 'admin';
}