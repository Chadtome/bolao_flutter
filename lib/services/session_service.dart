import 'package:bolao_/models/usuario.dart';

class SessionService {
  static Usuario? usuarioLogado;
  
  static void setUsuario(Usuario usuario) {
    usuarioLogado = usuario;
  }
  
  static Usuario? getUsuario() {
    return usuarioLogado;
  }
  
  static void logout() {
    usuarioLogado = null;
  }
  
  static bool isAdmin() {
    return usuarioLogado?.isAdmin ?? false;
  }
}