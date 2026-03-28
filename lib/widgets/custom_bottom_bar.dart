import 'package:bolao_/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget{
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final backgroundColor = isLight ? AppColors.lightSurface : AppColors.darkSurface;
    final selectedColor = isLight ? AppColors.lightPrimary : AppColors.darkPrimary;
    final unselectedColor = isLight ? AppColors.lightTextSecondary : AppColors.darkTextSecondary;

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: backgroundColor,
      selectedItemColor: selectedColor,
      unselectedItemColor: unselectedColor,
      items: const [
          BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Participantes',
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_score),
            label: 'Resultados',
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.table_chart),
            label: 'Tabela',
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Ranking',
            ),  
      ]
      );
  }

}