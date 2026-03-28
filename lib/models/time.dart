class Time {
    final int? id;
    final String nome;
    final String? logo;
    final int? grupoId;

    Time({
        this.id,
        required this.nome,
        required this.logo,
        this.grupoId,
    });

    Map<String, dynamic> toMap() {
        return {
            'id' : id,
            'nome' : nome,
            'logo' : logo,
            'grupo_id': grupoId
        };
    }

    factory Time.fromMap(Map<String, dynamic> map) {
        return Time(
            id: map['id'],
            nome: map['nome'],
            logo: map['logo'],
            grupoId: map['grupo_id'],
        );
    }
}