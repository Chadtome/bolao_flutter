import 'package:bolao_/services/session_service.dart';

class TimeControlService {
  // Data limite para CRIAÇÃO de participantes
  // Ajuste esta data conforme a necessidade
  static final DateTime dataLimiteCriacao = DateTime(2026, 4, 30, 23, 59, 59); //ano/mes/dia/hora/min/seg
  
  // Data limite para EDIÇÃO de participantes
  static final DateTime dataLimiteEdicao = DateTime(2026, 4, 30, 12, 00, 00); //ano/mes/dia/hora/min/seg
  
  // Verificar se pode criar
  static bool podeCriar() {
    final usuario = SessionService.getUsuario();
    
    // Admin sempre pode
    if (usuario != null && usuario.isAdmin) {
      return true;
    }
    
    // Usuário comum: verifica data/hora
    return DateTime.now().isBefore(dataLimiteCriacao);
  }
  
  // Verificar se pode editar
  static bool podeEditar() {
    final usuario = SessionService.getUsuario();
    
    // Admin sempre pode
    if (usuario != null && usuario.isAdmin) {
      return true;
    }
    
    // Usuário comum: verifica data/hora
    return DateTime.now().isBefore(dataLimiteEdicao);
  }
  
  // Retorna mensagem de erro para criação
  static String? getMensagemBloqueio() {
    if (podeCriar()) return null;
    
    return 'Prazo para criação de participantes encerrado em ${_formatarData(dataLimiteCriacao)}. Procure o administrador.';
  }
  
  // Retorna mensagem de erro para edição
  static String? getMensagemBloqueioEdicao() {
    if (podeEditar()) return null;
    
    return 'Prazo para edição de participantes encerrado em ${_formatarData(dataLimiteEdicao)}. Procure o administrador.';
  }
  
  static String _formatarData(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year} às ${data.hour.toString().padLeft(2, '0')}:${data.minute.toString().padLeft(2, '0')}';
  }
}