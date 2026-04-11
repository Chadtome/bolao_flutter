import 'package:bolao_/screens/classificacao/tela_classificacao.dart';
import 'package:bolao_/screens/participantes/lista_participantes.dart';
import 'package:bolao_/screens/participantes/tela_novo_partipante.dart';
import 'package:bolao_/screens/ranking/tela_ranking.dart';
import 'package:bolao_/screens/rodadas/tela_rodadas.dart';
import 'package:bolao_/screens/participantes/tela_participantes_menu.dart';
import 'package:bolao_/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';


class AppModule extends StatefulWidget {
  const AppModule({super.key});

  @override
  State<AppModule> createState() => _AppModuleState();
}

class _AppModuleState extends State<AppModule> {

  ThemeMode themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      themeMode =
          themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StyledToast(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      initialRoute: '/menu',
      routes: {
        '/menu': (context) => TelaParticipantesMenu(onToggleTheme: toggleTheme),
        '/novo_participante': (context) =>
          TelaNovoParticipante(onToggleTheme: toggleTheme),
        '/lista_participante': (context) =>
          ListaParticipantesScreen(onToggleTheme: toggleTheme,),
        '/rodadas': (context) =>
          TelaRodadas(onToggleTheme: toggleTheme),
        '/classificacao': (context) =>
          TelaClassificacao(onToggleTheme: toggleTheme),  
        '/ranking': (context) =>
          TelaRanking(onToggleTheme: toggleTheme),  

      },
    ),
    );
  }
}