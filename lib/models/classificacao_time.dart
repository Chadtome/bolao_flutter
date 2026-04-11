class ClassificacaoTime {
  final String nome;
  final String sigla;
  final String escudoPath;
  int pontos;
  int jogos;
  int vitorias;
  int empates;
  int derrotas;
  int golsPro;
  int golsContra;

  ClassificacaoTime({
    required this.nome,
    required this.sigla,
    required this.escudoPath,
    this.pontos = 0,
    this.jogos = 0,
    this.vitorias = 0,
    this.empates = 0,
    this.derrotas = 0,
    this.golsPro = 0,
    this.golsContra = 0,
  });

  int get saldoGols => golsPro - golsContra;

  int get criterioDesempate => (vitorias * 10000) + saldoGols;

  @override
  String toString() {
    return '$sigla: $pontos pontos, $vitorias V, $empates E, $derrotas D, '
        'GP: $golsPro, GC: $golsContra, SG: $saldoGols';
  }
}