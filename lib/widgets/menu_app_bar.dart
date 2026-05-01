import 'package:bolao_/services/session_service.dart';
import 'package:flutter/material.dart';
import 'package:bolao_/database/database_helper.dart';

class MenuAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onThemeToggle;
  final List<Widget>? actions;

  const MenuAppBar({
    Key? key,
    required this.title,
    this.onThemeToggle,
    this.actions,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Future<String?> _buscarNomeParticipante(int? participanteId) async {
    if (participanteId == null) return null;
    
    try {
      final participante = await DatabaseHelper.instance.buscarParticipantePorId(participanteId);
      return participante?.nome;
    } catch (e) {
      return null;
    }
  }

  void _mostrarModalUsuario(BuildContext context) async {
    final usuario = SessionService.getUsuario();
    
    String nomeParticipante = '';
    if (usuario?.isAdmin == true) {
      nomeParticipante = 'Administrador';
    } else if (usuario?.participanteId != null) {
      final nome = await _buscarNomeParticipante(usuario!.participanteId);
      nomeParticipante = nome ?? 'Participante não encontrado';
    } else {
      nomeParticipante = 'Nenhum participante vinculado';
    }
    
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Color(0xFF0B5D3B),
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  usuario?.login ?? 'Usuário',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  nomeParticipante,
                  style: TextStyle(
                    fontSize: 14,
                    color: usuario?.isAdmin == true 
                        ? Colors.amber.shade700 
                        : Colors.grey[600],
                    fontWeight: usuario?.isAdmin == true 
                        ? FontWeight.bold 
                        : FontWeight.normal,
                  ),
                ),
                const Divider(height: 32),
                // Opção Alterar Senha
                ListTile(
                  leading: const Icon(Icons.lock_outline, color: Color(0xFF0B5D3B)),
                  title: const Text('Alterar senha'),
                  onTap: () {
                    Navigator.pop(context);
                    _mostrarDialogAlterarSenha(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text(
                    'Sair',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _fazerLogout(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _mostrarDialogAlterarSenha(BuildContext context) {
    final senhaAtualController = TextEditingController();
    final novaSenhaController = TextEditingController();
    final confirmarSenhaController = TextEditingController();
    bool obscureAtual = true;
    bool obscureNova = true;
    bool obscureConfirmar = true;
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text('Alterar Senha'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: senhaAtualController,
                    obscureText: obscureAtual,
                    decoration: InputDecoration(
                      labelText: 'Senha atual',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(obscureAtual ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setStateDialog(() {
                            obscureAtual = !obscureAtual;
                          });
                        },
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: novaSenhaController,
                    obscureText: obscureNova,
                    decoration: InputDecoration(
                      labelText: 'Nova senha (mínimo 4 caracteres)',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(obscureNova ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setStateDialog(() {
                            obscureNova = !obscureNova;
                          });
                        },
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: confirmarSenhaController,
                    obscureText: obscureConfirmar,
                    decoration: InputDecoration(
                      labelText: 'Confirmar nova senha',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(obscureConfirmar ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setStateDialog(() {
                            obscureConfirmar = !obscureConfirmar;
                          });
                        },
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final senhaAtual = senhaAtualController.text;
                    final novaSenha = novaSenhaController.text;
                    final confirmarSenha = confirmarSenhaController.text;
                    
                    if (senhaAtual.isEmpty || novaSenha.isEmpty || confirmarSenha.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Preencha todos os campos')),
                      );
                      return;
                    }
                    
                    if (novaSenha.length < 4) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Nova senha deve ter no mínimo 4 caracteres')),
                      );
                      return;
                    }
                    
                    if (novaSenha != confirmarSenha) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('As senhas não coincidem')),
                      );
                      return;
                    }
                    
                    final usuario = SessionService.getUsuario();
                    if (usuario == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Usuário não encontrado')),
                      );
                      return;
                    }
                    
                    final usuarioValido = await DatabaseHelper.instance.buscarUsuario(
                      usuario.login,
                      senhaAtual,
                    );
                    
                    if (usuarioValido == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Senha atual incorreta')),
                      );
                      return;
                    }
                    
                    await DatabaseHelper.instance.alterarSenha(usuario.id!, novaSenha);
                    
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Senha alterada com sucesso!')),
                    );
                  },
                  child: const Text('Alterar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _fazerLogout(BuildContext context) {
    SessionService.logout();
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF0B5D3B),
      automaticallyImplyLeading: false,
      leading: null,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.brightness_6, color: Colors.white),
          onPressed: onThemeToggle,
        ),
        IconButton(
          icon: const Icon(Icons.account_circle, color: Colors.white),
          onPressed: () => _mostrarModalUsuario(context),
        ),
        if (actions != null) ...actions!,
      ],
    );
  }
}