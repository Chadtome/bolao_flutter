import 'package:bolao_/services/session_service.dart';
import 'package:bolao_/services/time_control_service.dart';
import 'package:bolao_/theme/app_colors.dart';
import 'package:bolao_/widgets/custom_bottom_bar.dart';
import 'package:bolao_/widgets/menu_app_bar.dart';
import 'package:bolao_/widgets/toast.widget.dart';
import 'package:flutter/material.dart';

class TelaParticipantesMenu extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const TelaParticipantesMenu({super.key, required this.onToggleTheme});

  @override
  State<TelaParticipantesMenu> createState() => _TelaParticipantesMenuState();
}

class _TelaParticipantesMenuState extends State<TelaParticipantesMenu> with AutomaticKeepAliveClientMixin {
  
  @override
  bool get wantKeepAlive => true;

  int selectedIndex = 1;

  void onBottomBarTap(int index) {
    setState(() {
      selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if(index == 2) {
      Navigator.pushReplacementNamed(context, '/rodadas');
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/classificacao');
    } else if (index == 4) {
      Navigator.pushReplacementNamed(context, '/ranking');
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final buttonColor = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final highlightColor = isDark ? AppColors.darkAccent : AppColors.lightAccent;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MenuAppBar(
        title: 'Participantes',
        onThemeToggle: widget.onToggleTheme,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Botão Novo Participante
            GestureDetector(
              key: const Key('btn_novo_participante'), // 👈 KEY ADICIONADA
              onTap: () {
                final usuarioLogado = SessionService.getUsuario();
                
                // Admin sempre pode criar
                if (usuarioLogado != null && usuarioLogado.isAdmin) {
                  Navigator.pushNamed(context, '/novo_participante');
                  return;
                }
                
                // Usuário comum: verificar se já tem participante
                if (usuarioLogado != null && usuarioLogado.participanteId != null) {
                  AppToast.error(
                    context: context,
                    text: 'Você já possui um participante cadastrado.',
                  );
                  return;
                }
                
                // Verificar prazo para criação
                if (!TimeControlService.podeCriar()) {
                  AppToast.error(
                    context: context,
                    text: TimeControlService.getMensagemBloqueio()!,
                  );
                  return;
                }
                
                Navigator.pushNamed(context, '/novo_participante');
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  border: Border.all(color: highlightColor, width: 1.5),
                ),
                child: Center(
                  child: Text(
                    'Novo Participante',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Botão Lista de Participantes
            GestureDetector(
              key: const Key('btn_lista_participantes'), // 👈 KEY ADICIONADA
              onTap: () {
                Navigator.pushNamed(context, '/lista_participante');
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  border: Border.all(color: highlightColor, width: 1.5),
                ),
                child: Center(
                  child: Text(
                    'Lista de Participantes',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: selectedIndex,
        onTap: onBottomBarTap,
      ),
    );
  }
}