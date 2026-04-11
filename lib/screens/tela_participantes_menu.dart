import 'package:bolao_/theme/app_colors.dart';
import 'package:bolao_/widgets/custom_appbar.dart';
import 'package:bolao_/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';

class TelaParticipantesMenu extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const TelaParticipantesMenu({super.key, required this.onToggleTheme});

  @override
  State<TelaParticipantesMenu> createState() => _TelaParticipantesMenuState();
}

class _TelaParticipantesMenuState extends State<TelaParticipantesMenu> {
  int selectedIndex = 1;

  void onBottomBarTap(int index) {
    setState(() {
      selectedIndex = index;
    });

    if(index == 2) {
      Navigator.pushNamed(context, '/rodadas');
    } else if (index == 3) {
      Navigator.pushNamed(context, '/classificacao');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final buttonColor = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final highlightColor = isDark ? AppColors.darkAccent : AppColors.lightAccent; // detalhe dourado

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface, // fundo
      appBar: CustomAppBar(
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
              onTap: () {

                Navigator.pushNamed(context, '/novo_participante');

                //navegação tela novo participantes;
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
                  border: Border.all(color: highlightColor, width: 1.5), // detalhe dourado
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