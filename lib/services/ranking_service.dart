// import 'package:bolao_/models/classificacao_time.dart';
// import 'package:bolao_/models/participante.dart';
// import 'package:bolao_/models/time.dart';

// class RankingService {

//   // Calcula a pontuação de cada participante baseado nos pontos dos seus times
//   static List<Map<String, dynamic>> calcularRanking(
//     List<Participante> participantes,
//     List<ClassificacaoTime> classificacao,
//     List<Time> times,
//   ) {
//     // Criar um mapa para facil acesso ao pontos de cada time
//     final Map<String, int> pontosPorTime = {};
//     for (var time in classificacao) {
//       pontosPorTime[time.sigla] = time.pontos;
//     }

//     // Criar um mapa para fácil acesso ao nome completo do time
//     final Map<String, String> nomePorSigla = {};
//     for (var time in times) {
//       nomePorSigla[time.abreviatura] = time.nome;
//     }

//     // Calcular pontuação de cada participante
//     final List<Map<String, dynamic>> ranking =[];

//     for (var participante in participantes) {
//       int pontuacaoTotal = 0;
//       final List<Map<String, dynamic>> timesDoParticipante = [];

//       // Percorrer oos grupos e times do participante
//       participante.grupos.forEach((grupo, idsTimes) {
//         for (var timeId in idsTimes) {
//           // Buscar o time pelo ID
//           final time = times.firstWhere(
//             (t) => t.id == timeId,
//             orElse: () => Time(id: 0, nome: 'Desconhecido', grupoId: 0, logo: '', abreviatura: ''),
//           );

//           final sigla = time.abreviatura;
//           final pontosTime = pontosPorTime[sigla] ?? 0;
//           pontuacaoTotal += pontosTime;

//           timesDoParticipante.add({
//             'sigla': sigla,
//             'nome': time.nome,
//             'pontos': pontosTime,
//             'grupo': grupo,
//           });
//         }
//       });

//       ranking.add({
//         'participante': participante,
//         'pontuacao': pontuacaoTotal,
//         'times': timesDoParticipante,
//       });
//     }

//     // Ordenar por pontuação
//     ranking.sort((a, b) => b['pontuacao'].compareTo(a['pontuacao']));

//     // Adicionar posição
//     for (int i = 0; i < ranking.length; i++) {
//       ranking[i]['posicao'] = i + 1;
//     }
    
//     return ranking;
//   }
// }

import 'package:bolao_/models/classificacao_time.dart';
import 'package:bolao_/models/participante.dart';
import 'package:bolao_/models/time.dart';
import 'cache_service.dart';

class RankingService {
  
  static List<Map<String, dynamic>> calcularRanking(
    List<Participante> participantes,
    List<ClassificacaoTime> classificacao,
    List<Time> times,
  ) {
    // Verifica se tem cache
    final cache = CacheService.getRanking();
    if (cache != null) {
      print('📦 Usando cache do ranking');
      return cache;
    }
    
    print('🔄 Calculando ranking do zero...');
    
    final Map<String, int> pontosPorTime = {};
    for (var time in classificacao) {
      pontosPorTime[time.sigla] = time.pontos;
    }
    
    final ranking = <Map<String, dynamic>>[];
    
    for (var participante in participantes) {
      int pontuacaoTotal = 0;
      final timesDoParticipante = <Map<String, dynamic>>[];
      
      participante.grupos.forEach((grupo, idsTimes) {
        for (var timeId in idsTimes) {
          final time = times.firstWhere(
            (t) => t.id == timeId,
            orElse: () => Time(id: 0, nome: 'Desconhecido', grupoId: 0, logo: '', abreviatura: ''),
          );
          
          final sigla = time.abreviatura;
          final pontosTime = pontosPorTime[sigla] ?? 0;
          pontuacaoTotal += pontosTime;
          
          timesDoParticipante.add({
            'sigla': sigla,
            'nome': time.nome,
            'pontos': pontosTime,
            'grupo': grupo,
          });
        }
      });
      
      ranking.add({
        'participante': participante,
        'pontuacao': pontuacaoTotal,
        'times': timesDoParticipante,
      });
    }
    
    ranking.sort((a, b) => b['pontuacao'].compareTo(a['pontuacao']));
    
    for (int i = 0; i < ranking.length; i++) {
      ranking[i]['posicao'] = i + 1;
    }
    
    // Salva no cache
    CacheService.setRanking(ranking);
    
    return ranking;
  }
}