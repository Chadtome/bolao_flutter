class Resultado {
  int? id;
  int rodada;
  String timeA;
  String timeB;
  int? golsA;
  int? golsB;

  Resultado({
    this.id,
    required this.rodada,
    required this.timeA,
    required this.timeB,
    this.golsA,
    this.golsB,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rodada': rodada,
      'timeA': timeA,
      'timeB': timeB,
      'golsA': golsA,
      'golsB': golsB,
    };
  }

  factory Resultado.fromMap(Map<String, dynamic> map) {
    return Resultado(
      id: map['id'],
      rodada: map['rodada'], 
      timeA: map['timeA'], 
      timeB: map['timeB'],
      golsA: map['golsA'],
      golsB: map['golsB'],
      );
  }
}