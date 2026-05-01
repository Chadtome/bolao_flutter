import 'package:bolao_/database/database_helper.dart';
import 'package:bolao_/models/participante.dart';
import 'package:bolao_/services/classificacao_service.dart';
import 'package:bolao_/services/pdf_export_service.dart';
import 'package:bolao_/services/ranking_service.dart';
import 'package:bolao_/widgets/custom_bottom_bar.dart';
import 'package:bolao_/widgets/menu_app_bar.dart';
import 'package:bolao_/widgets/toast.widget.dart';
import 'package:flutter/material.dart';

class TelaRanking extends StatefulWidget {
  final VoidCallback onToggleTheme;
  const TelaRanking({super.key, required this.onToggleTheme});

  @override
  State<TelaRanking> createState() => _TelaRankingState();
}

class _TelaRankingState extends State<TelaRanking> with AutomaticKeepAliveClientMixin {
  
  @override
  bool get wantKeepAlive => true;

  int selectedIndex = 4;
  List<Map<String, dynamic>> _ranking = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarRanking();
  }

  Future<void> _carregarRanking() async {
    setState(() {
      _carregando = true;
    });

    try {
      final times = await DatabaseHelper.instance.buscarTodosOsTimes();
      final resultados = await DatabaseHelper.instance.buscarTodosOsResultados();
      final participantes = await DatabaseHelper.instance.buscarParticipantes();
      
      final classificacao = ClassificacaoService.calcularClassificacao(
        times,
        resultados,
      );
      
      final ranking = RankingService.calcularRanking(
        participantes,
        classificacao,
        times,
      );
      
      setState(() {
        _ranking = ranking;
        _carregando = false;
      });
    } catch (e) {
      print('Erro ao carregar ranking: $e');
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
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/classificacao');
    }
  }

  Future<void> _exportarPDF() async {
    try {
      await PdfExportService.gerarECompartilharRanking(_ranking);
    } catch (e) {
      AppToast.error(context: context, text: 'Erro ao gerar PDF');
    }
  }

  void _mostrarDetalhesParticipante(Map<String, dynamic> item) {
    final participante = item['participante'] as Participante;
    final pontuacao = item['pontuacao'] as int;
    final times = item['times'] as List<Map<String, dynamic>>;
    
    final Map<String, List<Map<String, dynamic>>> timesPorGrupo = {};
    for (var time in times) {
      final grupo = time['grupo'] as String;
      if (!timesPorGrupo.containsKey(grupo)) {
        timesPorGrupo[grupo] = [];
      }
      timesPorGrupo[grupo]!.add(time);
    }
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.3,
          maxChildSize: 0.8,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    participante.nome,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Total: $pontuacao pontos',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: timesPorGrupo.keys.length,
                      itemBuilder: (context, grupoIndex) {
                        final grupo = timesPorGrupo.keys.elementAt(grupoIndex);
                        final timesDoGrupo = timesPorGrupo[grupo]!;
                        
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                grupo,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            ...timesDoGrupo.map((time) => Padding(
                              padding: const EdgeInsets.only(left: 16, bottom: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      time['nome'],
                                      style: const TextStyle(fontSize: 14),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      '${time['pontos']} pts',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                            const SizedBox(height: 8),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: MenuAppBar(
        title: 'Ranking',
        onThemeToggle: widget.onToggleTheme,
        actions: [
          IconButton(
            onPressed: _exportarPDF,
            icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
            tooltip: 'Exportar e Compartilhar PDF',
          ),
        ],
      ),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : _ranking.isEmpty
              ? const Center(child: Text('Nenhum participante cadastrado'))
              : Column(
                  children: [
                    const SizedBox(height: 12),
                    _buildHeader(),
                    Expanded(
                      child: ListView.builder(
                        key: const PageStorageKey('ranking_list'), // 👈 KEY ADICIONADA
                        itemCount: _ranking.length,
                        itemBuilder: (context, index) {
                          final item = _ranking[index];
                          final participante = item['participante'] as Participante;
                          return Container(
                            key: ValueKey(participante.id), // 👈 KEY ADICIONADA
                            child: _buildRow(item, index),
                          );
                        },
                      ),
                    ),
                  ],
                ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: selectedIndex,
        onTap: onBottomBarTap,
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor, width: 1),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 50,
            child: Text(
              'Pos',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Participante',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            width: 60,
            child: Text(
              'Pontos',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(Map<String, dynamic> item, int index) {
    final participante = item['participante'] as Participante;
    final pontuacao = item['pontuacao'] as int;
    final posicao = item['posicao'] as int;
    
    Color? getPosicaoColor() {
      if (posicao == 1) return Colors.amber.shade700;
      if (posicao == 2) return Colors.grey.shade400;
      if (posicao == 3) return Colors.brown.shade300;
      return null;
    }
    
    return InkWell(
      onTap: () => _mostrarDetalhesParticipante(item),
      child: Container(
        decoration: BoxDecoration(
          color: index % 2 == 1 
              ? Theme.of(context).primaryColor.withOpacity(0.05)
              : null,
          border: Border(
            bottom: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              child: Text(
                '$posicao',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: getPosicaoColor(),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                participante.nome,
                style: const TextStyle(fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: 60,
              child: Text(
                '$pontuacao',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}