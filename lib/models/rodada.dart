import 'package:bolao_/models/jogo.dart';

class Rodada {
  final int numero;
  final String data;
  final List<Jogo> jogos;

  Rodada({
    required this.numero,
    required this.data,
    required this.jogos
  });
}