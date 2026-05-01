// import 'package:bolao_/models/classificacao_time.dart';
// import 'package:bolao_/models/resultado.dart';
// import 'package:bolao_/models/time.dart';

// class ClassificacaoService {

//   /// Calcula a classificação completa com base nos times e resultados

//   static List<ClassificacaoTime> calcularClassificacao(
//     List<Time> times,
//     List<Resultado> resultados,
//   ) {
//     // Criar um mapa para fácil acesso aos dados de cada time
//     final Map<String, ClassificacaoTime> classificacaoMap = {};

//     // Inicializar todos os times com zero
//     for (var time in times) {
//       classificacaoMap[time.abreviatura] = ClassificacaoTime(
//         nome: time.nome, 
//         sigla: time.abreviatura, 
//         escudoPath: time.logo ?? '',
//         );
//     }

//     // Processar cada resultado
//     for (var resultado in resultados) {
//       // Pular resultado incompletos (sem gols)
//       if (resultado.golsA == null || resultado.golsB == null) continue;

//       final golsA = resultado.golsA!;
//       final golsB = resultado.golsB!;
//       final timeA = resultado.timeA;
//       final timeB = resultado.timeB;

//        // Atualizar estatísticas do time A
//       _atualizarEstatisticas(classificacaoMap[timeA], golsA, golsB);
      
//       // Atualizar estatísticas do time B
//       _atualizarEstatisticas(classificacaoMap[timeB], golsB, golsA);
//     }

//     // Converter para lista e ordenar
//     List<ClassificacaoTime> classificacao = classificacaoMap.values.toList();
//     classificacao.sort(_ordenarTimes);
    
//     return classificacao;
//   }

//   /// Atualiza as estatisticas de um time baseado no resultado
//   static void _atualizarEstatisticas(
//     ClassificacaoTime? time,
//     int golsFeitos,
//     int golsSofridos,
//   ) {
//     if (time == null) return;

//     time.jogos++;
//     time.golsPro += golsFeitos;
//     time.golsContra += golsSofridos;

//     if (golsFeitos > golsSofridos) {
//       // Vitoria
//       time.vitorias++;
//       time.pontos += 3;
//       } else if (golsFeitos == golsSofridos) {
//         // Empate
//         time.empates++;
//         time.pontos += 1;
//         } else {
//           // Derrota
//           time.derrotas ++;
//         }
//   }

//   /// Critérios de ordenação:
//   /// 1. Pontos (maior)
//   /// 2. Vitórias (maior)
//   /// 3. Saldo de gols (maior)
//   /// 4. Gols pró (maior)
  
//   static int _ordenarTimes(ClassificacaoTime a, ClassificacaoTime b) {
//     // Comparar pontos
//     if (a.pontos != b.pontos) {
//       return b.pontos.compareTo(a.pontos);
//     }

//     // Comparar vitórias
//     if (a.vitorias != b.vitorias) {
//       return b.vitorias.compareTo(a.vitorias);
//     }
//     // Comparar saldo de gols
//     if (a.saldoGols != b.saldoGols) {
//       return b.saldoGols.compareTo(a.saldoGols);
//     }

//      // Comparar gols pró
//     return b.golsPro.compareTo(a.golsPro);
//   }
  
// }
import 'package:bolao_/models/classificacao_time.dart';
import 'package:bolao_/models/resultado.dart';
import 'package:bolao_/models/time.dart';
import 'cache_service.dart';

class ClassificacaoService {

  static List<ClassificacaoTime> calcularClassificacao(
    List<Time> times,
    List<Resultado> resultados,
  ) {
    // Se tiver cache válido, usa o cache
    if (CacheService.isCacheValido()) {
      final cache = CacheService.getClassificacao();
      if (cache != null) {
        print('📦 Usando cache da classificação');
        return cache;
      }
    }
    
    print('🔄 Calculando classificação do zero...');
    
    final Map<String, ClassificacaoTime> classificacaoMap = {};

    for (var time in times) {
      classificacaoMap[time.abreviatura] = ClassificacaoTime(
        nome: time.nome, 
        sigla: time.abreviatura, 
        escudoPath: time.logo ?? '',
      );
    }

    for (var resultado in resultados) {
      if (resultado.golsA == null || resultado.golsB == null) continue;

      final golsA = resultado.golsA!;
      final golsB = resultado.golsB!;
      final timeA = resultado.timeA;
      final timeB = resultado.timeB;

      _atualizarEstatisticas(classificacaoMap[timeA], golsA, golsB);
      _atualizarEstatisticas(classificacaoMap[timeB], golsB, golsA);
    }

    List<ClassificacaoTime> classificacao = classificacaoMap.values.toList();
    classificacao.sort(_ordenarTimes);
    
    // Salva no cache
    CacheService.setClassificacao(classificacao);
    
    return classificacao;
  }

  static void _atualizarEstatisticas(
    ClassificacaoTime? time,
    int golsFeitos,
    int golsSofridos,
  ) {
    if (time == null) return;

    time.jogos++;
    time.golsPro += golsFeitos;
    time.golsContra += golsSofridos;

    if (golsFeitos > golsSofridos) {
      time.vitorias++;
      time.pontos += 3;
    } else if (golsFeitos == golsSofridos) {
      time.empates++;
      time.pontos += 1;
    } else {
      time.derrotas++;
    }
  }

  static int _ordenarTimes(ClassificacaoTime a, ClassificacaoTime b) {
    if (a.pontos != b.pontos) {
      return b.pontos.compareTo(a.pontos);
    }
    if (a.vitorias != b.vitorias) {
      return b.vitorias.compareTo(a.vitorias);
    }
    if (a.saldoGols != b.saldoGols) {
      return b.saldoGols.compareTo(a.saldoGols);
    }
    return b.golsPro.compareTo(a.golsPro);
  }
}