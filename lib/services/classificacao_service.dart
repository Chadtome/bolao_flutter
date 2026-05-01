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