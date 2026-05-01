// import 'package:bolao_/database/database_helper.dart';
// import 'package:bolao_/models/classificacao_time.dart';
// import 'package:bolao_/services/classificacao_service.dart';
// import 'package:bolao_/widgets/custom_bottom_bar.dart';
// import 'package:bolao_/widgets/menu_app_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class TelaClassificacao extends StatefulWidget {
//   final VoidCallback onToggleTheme;
//   const TelaClassificacao({super.key, required this.onToggleTheme});

//   @override
//   State<TelaClassificacao> createState() => _TelaClassificacaoState();
// }

// class _TelaClassificacaoState extends State<TelaClassificacao> with AutomaticKeepAliveClientMixin {
  
//   @override
//   bool get wantKeepAlive => true;

//   int selectedIndex = 3;
//   List<ClassificacaoTime> _classificacao = [];
//   bool _carregando = true;
  
//   final ScrollController _scrollController = ScrollController();
//   double _scrollOffset = 0;

//   @override
//   void initState() {
//     super.initState();
//     _carregarClassificacao();
//     _scrollController.addListener(() {
//       setState(() {
//         _scrollOffset = _scrollController.offset;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   Future<void> _carregarClassificacao() async {
//     setState(() {
//       _carregando = true;
//     });

//     try {
//       final times = await DatabaseHelper.instance.buscarTodosOsTimes();
//       final resultados = await DatabaseHelper.instance.buscarTodosOsResultados();
      
//       final classificacao = ClassificacaoService.calcularClassificacao(
//         times,
//         resultados,
//       );
      
//       setState(() {
//         _classificacao = classificacao;
//         _carregando = false;
//       });
//     } catch (e) {
//       print('Erro ao carregar classificação: $e');
//       setState(() {
//         _carregando = false;
//       });
//     }
//   }

//   void onBottomBarTap(int index) {
//     setState(() {
//       selectedIndex = index;
//     });

//     if (index == 0) {
//       Navigator.pushReplacementNamed(context, '/home');
//     } else if (index == 1) {
//       Navigator.pushReplacementNamed(context, '/menu');
//     } else if (index == 2) {
//       Navigator.pushReplacementNamed(context, '/rodadas');
//     } else if (index == 4) {
//       Navigator.pushReplacementNamed(context, '/ranking');
//     }
//   }

//   // Larguras das colunas
//   double getLarguraColuna(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     return (screenWidth - 144) / 8; // 120 da esquerda + 24 padding = 144
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context); // 👈 LINHA IMPORTANTE

//     final larguraColuna = getLarguraColuna(context);
//     final screenWidth = MediaQuery.of(context).size.width;
    
//     // Posições das colunas destacadas
//     final posicaoColunaP = 120.0; // depois da coluna da esquerda
//     final posicaoColunaV = posicaoColunaP + (larguraColuna * 2); // pula J
//     final posicaoColunaD = posicaoColunaV + (larguraColuna * 2); // pula E
//     final posicaoColunaGC = posicaoColunaD + (larguraColuna * 2); // pula GP
    
//     final alturaCabecalho = 50.0;
//     final alturaLinha = 60.0;
    
//     return Scaffold(
//       appBar: MenuAppBar(
//         title: 'Classificação',
//         onThemeToggle: widget.onToggleTheme,
//       ),
//       body: _carregando
//           ? const Center(child: CircularProgressIndicator())
//           : Stack(
//               children: [
//                 // Fundo colorido das colunas
//                 Positioned(
//                   top: alturaCabecalho - _scrollOffset,
//                   left: posicaoColunaP + 12,
//                   width: larguraColuna,
//                   height: _classificacao.length * alturaLinha,
//                   child: Container(
//                     color: Theme.of(context).primaryColor.withOpacity(0.08),
//                   ),
//                 ),
//                 Positioned(
//                   top: alturaCabecalho - _scrollOffset,
//                   left: posicaoColunaV + 12,
//                   width: larguraColuna,
//                   height: _classificacao.length * alturaLinha,
//                   child: Container(
//                     color: Theme.of(context).primaryColor.withOpacity(0.08),
//                   ),
//                 ),
//                 Positioned(
//                   top: alturaCabecalho - _scrollOffset,
//                   left: posicaoColunaD + 12,
//                   width: larguraColuna,
//                   height: _classificacao.length * alturaLinha,
//                   child: Container(
//                     color: Theme.of(context).primaryColor.withOpacity(0.08),
//                   ),
//                 ),
//                 Positioned(
//                   top: alturaCabecalho - _scrollOffset,
//                   left: posicaoColunaGC + 12,
//                   width: larguraColuna,
//                   height: _classificacao.length * alturaLinha,
//                   child: Container(
//                     color: Theme.of(context).primaryColor.withOpacity(0.08),
//                   ),
//                 ),
                
//                 // Conteúdo principal
//                 Column(
//                   children: [
//                     _buildHeader(larguraColuna),
//                     Expanded(
//                       child: ListView.builder(
//                         controller: _scrollController,
//                         itemCount: _classificacao.length,
//                         itemBuilder: (context, index) {
//                           return _buildRow(_classificacao[index], index + 1, larguraColuna);
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//       bottomNavigationBar: CustomBottomBar(
//         currentIndex: selectedIndex,
//         onTap: onBottomBarTap,
//       ),
//     );
//   }

//   Widget _buildHeader(double larguraColuna) {
//     return Container(
//       height: 50,
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//       decoration: BoxDecoration(
//         color: Theme.of(context).primaryColor.withOpacity(0.1),
//         border: Border(
//           bottom: BorderSide(color: Theme.of(context).dividerColor, width: 1),
//         ),
//       ),
//       child: Row(
//         children: [
//           const SizedBox(
//             width: 120,
//             child: Center(
//               child: Text(
//                 'Classificação',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//           SizedBox(
//             width: larguraColuna,
//             child: const Text('P', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
//           ),
//           SizedBox(
//             width: larguraColuna,
//             child: const Text('J', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
//           ),
//           SizedBox(
//             width: larguraColuna,
//             child: const Text('V', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
//           ),
//           SizedBox(
//             width: larguraColuna,
//             child: const Text('E', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
//           ),
//           SizedBox(
//             width: larguraColuna,
//             child: const Text('D', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
//           ),
//           SizedBox(
//             width: larguraColuna,
//             child: const Text('GP', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
//           ),
//           SizedBox(
//             width: larguraColuna,
//             child: const Text('GC', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
//           ),
//           SizedBox(
//             width: larguraColuna,
//             child: const Text('SG', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildRow(ClassificacaoTime time, int posicao, double larguraColuna) {
//     return Container(
//       height: 50,
//       decoration: BoxDecoration(
//         border: Border(
//           bottom: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
//         ),
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       child: Row(
//         children: [
//           // Coluna da esquerda
//           SizedBox(
//             width: 120,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(width: 35, child: Text('$posicao', textAlign: TextAlign.center)),
//                 const SizedBox(width: 4),
//                 SvgPicture.asset(
//                   time.escudoPath,
//                   width: 26,
//                   height: 26,
//                   placeholderBuilder: (context) => const SizedBox(width: 26, height: 26),
//                 ),
//                 const SizedBox(width: 4),
//                 SizedBox(
//                   width: 35,
//                   child: Text(
//                     time.sigla,
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(fontWeight: FontWeight.w500),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // P
//           SizedBox(
//             width: larguraColuna,
//             child: Text('${time.pontos}', textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
//           ),
//           // J
//           SizedBox(
//             width: larguraColuna,
//             child: Text('${time.jogos}', textAlign: TextAlign.center),
//           ),
//           // V
//           SizedBox(
//             width: larguraColuna,
//             child: Text('${time.vitorias}', textAlign: TextAlign.center),
//           ),
//           // E
//           SizedBox(
//             width: larguraColuna,
//             child: Text('${time.empates}', textAlign: TextAlign.center),
//           ),
//           // D
//           SizedBox(
//             width: larguraColuna,
//             child: Text('${time.derrotas}', textAlign: TextAlign.center),
//           ),
//           // GP
//           SizedBox(
//             width: larguraColuna,
//             child: Text('${time.golsPro}', textAlign: TextAlign.center),
//           ),
//           // GC
//           SizedBox(
//             width: larguraColuna,
//             child: Text('${time.golsContra}', textAlign: TextAlign.center),
//           ),
//           // SG
//           SizedBox(
//             width: larguraColuna,
//             child: Text(
//               '${time.saldoGols}',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: time.saldoGols > 0 ? Colors.green : (time.saldoGols < 0 ? Colors.red : null),
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:bolao_/database/database_helper.dart';
import 'package:bolao_/models/classificacao_time.dart';
import 'package:bolao_/services/classificacao_service.dart';
import 'package:bolao_/widgets/custom_bottom_bar.dart';
import 'package:bolao_/widgets/menu_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TelaClassificacao extends StatefulWidget {
  final VoidCallback onToggleTheme;
  const TelaClassificacao({super.key, required this.onToggleTheme});

  @override
  State<TelaClassificacao> createState() => _TelaClassificacaoState();
}

class _TelaClassificacaoState extends State<TelaClassificacao> with AutomaticKeepAliveClientMixin {
  
  @override
  bool get wantKeepAlive => true;

  int selectedIndex = 3;
  List<ClassificacaoTime> _classificacao = [];
  bool _carregando = true;
  
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _carregarClassificacao();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _carregarClassificacao() async {
    setState(() {
      _carregando = true;
    });

    try {
      final times = await DatabaseHelper.instance.buscarTodosOsTimes();
      final resultados = await DatabaseHelper.instance.buscarTodosOsResultados();
      
      final classificacao = ClassificacaoService.calcularClassificacao(
        times,
        resultados,
      );
      
      setState(() {
        _classificacao = classificacao;
        _carregando = false;
      });
    } catch (e) {
      print('Erro ao carregar classificação: $e');
      setState(() {
        _carregando = false;
      });
    }
  }

  void onBottomBarTap(int index) {
    setState(() {
      selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/menu');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/rodadas');
    } else if (index == 4) {
      Navigator.pushReplacementNamed(context, '/ranking');
    }
  }

  // Larguras das colunas
  double getLarguraColuna(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return (screenWidth - 144) / 8; // 120 da esquerda + 24 padding = 144
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final larguraColuna = getLarguraColuna(context);
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Posições das colunas destacadas
    final posicaoColunaP = 120.0; // depois da coluna da esquerda
    final posicaoColunaV = posicaoColunaP + (larguraColuna * 2); // pula J
    final posicaoColunaD = posicaoColunaV + (larguraColuna * 2); // pula E
    final posicaoColunaGC = posicaoColunaD + (larguraColuna * 2); // pula GP
    
    final alturaCabecalho = 50.0;
    final alturaLinha = 60.0;
    
    return Scaffold(
      appBar: MenuAppBar(
        title: 'Classificação',
        onThemeToggle: widget.onToggleTheme,
      ),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                // Fundo colorido das colunas
                Positioned(
                  top: alturaCabecalho - _scrollOffset,
                  left: posicaoColunaP + 12,
                  width: larguraColuna,
                  height: _classificacao.length * alturaLinha,
                  child: Container(
                    color: Theme.of(context).primaryColor.withOpacity(0.08),
                  ),
                ),
                Positioned(
                  top: alturaCabecalho - _scrollOffset,
                  left: posicaoColunaV + 12,
                  width: larguraColuna,
                  height: _classificacao.length * alturaLinha,
                  child: Container(
                    color: Theme.of(context).primaryColor.withOpacity(0.08),
                  ),
                ),
                Positioned(
                  top: alturaCabecalho - _scrollOffset,
                  left: posicaoColunaD + 12,
                  width: larguraColuna,
                  height: _classificacao.length * alturaLinha,
                  child: Container(
                    color: Theme.of(context).primaryColor.withOpacity(0.08),
                  ),
                ),
                Positioned(
                  top: alturaCabecalho - _scrollOffset,
                  left: posicaoColunaGC + 12,
                  width: larguraColuna,
                  height: _classificacao.length * alturaLinha,
                  child: Container(
                    color: Theme.of(context).primaryColor.withOpacity(0.08),
                  ),
                ),
                
                // Conteúdo principal
                Column(
                  children: [
                    _buildHeader(larguraColuna),
                    Expanded(
                      child: ListView.builder(
                        key: const PageStorageKey('classificacao_list'), // 👈 KEY ADICIONADA
                        controller: _scrollController,
                        itemCount: _classificacao.length,
                        itemBuilder: (context, index) {
                          return Container(
                            key: ValueKey(_classificacao[index].sigla), // 👈 KEY ADICIONADA
                            child: _buildRow(_classificacao[index], index + 1, larguraColuna),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: selectedIndex,
        onTap: onBottomBarTap,
      ),
    );
  }

  Widget _buildHeader(double larguraColuna) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor, width: 1),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 120,
            child: Center(
              child: Text(
                'Classificação',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            width: larguraColuna,
            child: const Text('P', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          ),
          SizedBox(
            width: larguraColuna,
            child: const Text('J', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          ),
          SizedBox(
            width: larguraColuna,
            child: const Text('V', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          ),
          SizedBox(
            width: larguraColuna,
            child: const Text('E', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          ),
          SizedBox(
            width: larguraColuna,
            child: const Text('D', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          ),
          SizedBox(
            width: larguraColuna,
            child: const Text('GP', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          ),
          SizedBox(
            width: larguraColuna,
            child: const Text('GC', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          ),
          SizedBox(
            width: larguraColuna,
            child: const Text('SG', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(ClassificacaoTime time, int posicao, double larguraColuna) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          // Coluna da esquerda
          SizedBox(
            width: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 35, child: Text('$posicao', textAlign: TextAlign.center)),
                const SizedBox(width: 4),
                SvgPicture.asset(
                  time.escudoPath,
                  width: 26,
                  height: 26,
                  placeholderBuilder: (context) => const SizedBox(width: 26, height: 26),
                ),
                const SizedBox(width: 4),
                SizedBox(
                  width: 35,
                  child: Text(
                    time.sigla,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          // P
          SizedBox(
            width: larguraColuna,
            child: Text('${time.pontos}', textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          // J
          SizedBox(
            width: larguraColuna,
            child: Text('${time.jogos}', textAlign: TextAlign.center),
          ),
          // V
          SizedBox(
            width: larguraColuna,
            child: Text('${time.vitorias}', textAlign: TextAlign.center),
          ),
          // E
          SizedBox(
            width: larguraColuna,
            child: Text('${time.empates}', textAlign: TextAlign.center),
          ),
          // D
          SizedBox(
            width: larguraColuna,
            child: Text('${time.derrotas}', textAlign: TextAlign.center),
          ),
          // GP
          SizedBox(
            width: larguraColuna,
            child: Text('${time.golsPro}', textAlign: TextAlign.center),
          ),
          // GC
          SizedBox(
            width: larguraColuna,
            child: Text('${time.golsContra}', textAlign: TextAlign.center),
          ),
          // SG
          SizedBox(
            width: larguraColuna,
            child: Text(
              '${time.saldoGols}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: time.saldoGols > 0 ? Colors.green : (time.saldoGols < 0 ? Colors.red : null),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}