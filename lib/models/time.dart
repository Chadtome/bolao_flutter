class Time {
    final int? id;
    final String nome;
    final String? logo;

    Time({
        this.id,
        required this.nome,
        required this.logo
    });

    Map<String, dynamic> toMap() {
        return {
            'id' : id,
            'nome' : nome,
            'logo' : logo,
        };
    }

    factory Time.fromMap(Map<String, dynamic> map) {
        return Time(
            id: map['id'],
            nome: map['nome'],
            logo: map['logo'],
        );
    }
}