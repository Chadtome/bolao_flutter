import 'package:bolao_/models/classificacao_time.dart';

class CacheService {
  static List<ClassificacaoTime>? _classificacaoCache;
  static List<Map<String, dynamic>>? _rankingCache;
  static DateTime? _ultimaAtualizacao;
  
  // Cache válido por 30 segundos
  static bool isCacheValido() {
    if (_classificacaoCache == null || _ultimaAtualizacao == null) {
      return false;
    }
    return DateTime.now().difference(_ultimaAtualizacao!).inSeconds < 30;
  }
  
  static void setClassificacao(List<ClassificacaoTime> classificacao) {
    _classificacaoCache = classificacao;
    _ultimaAtualizacao = DateTime.now();
  }
  
  static List<ClassificacaoTime>? getClassificacao() {
    return _classificacaoCache;
  }
  
  static void setRanking(List<Map<String, dynamic>> ranking) {
    _rankingCache = ranking;
  }
  
  static List<Map<String, dynamic>>? getRanking() {
    return _rankingCache;
  }
  
  static void limparCache() {
    _classificacaoCache = null;
    _rankingCache = null;
    _ultimaAtualizacao = null;
  }
}