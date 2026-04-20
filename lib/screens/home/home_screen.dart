import 'package:bolao_/data/rodada_mock.dart';
import 'package:bolao_/database/database_helper.dart';
import 'package:bolao_/models/classificacao_time.dart';
import 'package:bolao_/services/classificacao_service.dart';
import 'package:bolao_/services/ranking_service.dart';
import 'package:bolao_/services/session_service.dart';
import 'package:bolao_/widgets/custom_bottom_bar.dart';
import 'package:bolao_/widgets/menu_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  const HomeScreen({super.key, required this.onToggleTheme});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _ranking = [];
  List<ClassificacaoTime> _classificacao = [];
  bool _carregando = true;
  int? _posicaoUsuario;
  int? _pontuacaoUsuario;
  String? _nomeUsuario;
  int selectedIndex = 0;
  bool _expandedRanking = false;
  bool _expandedProximas = false;
  
  Map<String, dynamic>? _proximaRodada;
  List<Map<String, dynamic>> _proximosJogos = [];

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  void onBottomBarTap(int index) {
    setState(() {
      selectedIndex = index;
    });

    switch (index) {
      case 1:
        Navigator.pushReplacementNamed(context, '/menu');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/rodadas');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/classificacao');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/ranking');
        break;
    }
  }

  void _calcularProximaRodada() {
    final hoje = DateTime.now();
    for (int i = 0; i < rodadasMock.length; i++) {
      final rodadaData = DateTime.parse(rodadasMock[i].data);
      if (!rodadaData.isBefore(DateTime(hoje.year, hoje.month, hoje.day))) {
        _proximaRodada = {
          'numero': rodadasMock[i].numero,
          'data': rodadasMock[i].data,
          'jogos': rodadasMock[i].jogos,
        };
        
        _proximosJogos = rodadasMock[i].jogos.map((jogo) {
          return {
            'timeA': jogo.timeA,
            'timeB': jogo.timeB,
            'escudoA': jogo.escudoA,
            'escudoB': jogo.escudoB,
          };
        }).toList();
        break;
      }
    }
  }

  Future<void> _carregarDados() async {
    setState(() {
      _carregando = true;
    });

    try {
      final times = await DatabaseHelper.instance.buscarTodosOsTimes();
      final resultados = await DatabaseHelper.instance.buscarTodosOsResultados();
      final participantes = await DatabaseHelper.instance.buscarParticipantes();
      final usuario = SessionService.getUsuario();
      
      _classificacao = ClassificacaoService.calcularClassificacao(times, resultados);
      _ranking = RankingService.calcularRanking(participantes, _classificacao, times);
      
      _calcularProximaRodada();
      
      if (usuario != null) {
        if (usuario.isAdmin) {
          _nomeUsuario = 'Administrador';
          _posicaoUsuario = null;
          _pontuacaoUsuario = null;
        } else if (usuario.participanteId != null) {
          final participante = await DatabaseHelper.instance.buscarParticipantePorId(usuario.participanteId!);
          if (participante != null) {
            _nomeUsuario = participante.nome;
            for (int i = 0; i < _ranking.length; i++) {
              if (_ranking[i]['participante'].id == participante.id) {
                _posicaoUsuario = i + 1;
                _pontuacaoUsuario = _ranking[i]['pontuacao'];
                break;
              }
            }
          }
        } else {
          _nomeUsuario = null;
        }
      }
      
      setState(() {
        _carregando = false;
      });
    } catch (e) {
      print('Erro ao carregar home: $e');
      setState(() {
        _carregando = false;
      });
    }
  }

  String _formatarData(String dataIso) {
    final data = DateTime.parse(dataIso);
    return '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: MenuAppBar(
        title: 'Bolão 2026',
        onThemeToggle: widget.onToggleTheme,
      ),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _carregarDados,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWelcomeBanner(),
                    const SizedBox(height: 24),
                    _buildRankingCard(),
                    const SizedBox(height: 16),
                    if (_proximaRodada != null)
                      _buildProximaRodadaCard(),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: selectedIndex,
        onTap: onBottomBarTap,
      ),
    );
  }

  Widget _buildWelcomeBanner() {
    final usuario = SessionService.getUsuario();
    final isAdmin = usuario?.isAdmin ?? false;
    final temParticipante = _nomeUsuario != null && !isAdmin;
    
    String mensagemBoasVindas;
    if (isAdmin) {
      mensagemBoasVindas = 'Bem-vindo, Administrador!';
    } else if (temParticipante) {
      mensagemBoasVindas = 'Bem-vindo, $_nomeUsuario!';
    } else {
      mensagemBoasVindas = 'Bem-vindo, Participante!';
    }
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF0B5D3B), const Color(0xFF0B5D3B).withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mensagemBoasVindas,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          if (temParticipante && _posicaoUsuario != null) ...[
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Sua posição: $_posicaoUsuarioº',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (_posicaoUsuario! <= 5)
                  const Icon(Icons.emoji_events, color: Colors.amber, size: 20),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '$_pontuacaoUsuario pontos',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ] else if (!temParticipante && !isAdmin) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Cadastre seu participante no menu',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRankingCard() {
    final top5 = _ranking.take(5).toList();
    final ultimo = _ranking.isNotEmpty ? _ranking.last : null;
    final posicaoUltimo = _ranking.length;
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              setState(() {
                _expandedRanking = !_expandedRanking;
              });
            },
            leading: const Icon(Icons.emoji_events, color: Colors.amber),
            title: const Text(
              'PREMIADOS',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Icon(
              _expandedRanking ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            ),
          ),
          if (_expandedRanking) ...[
            ...top5.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final participante = item['participante'];
              final pontuacao = item['pontuacao'];
              
              Color? getMedalColor() {
                if (index == 0) return Colors.amber.shade700;
                if (index == 1) return Colors.grey.shade400;
                if (index == 2) return Colors.brown.shade300;
                return null;
              }
              
              final isDark = Theme.of(context).brightness == Brightness.dark;
              final pontuacaoColor = isDark ? Colors.green.shade300 : const Color(0xFF0B5D3B);
              
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                      child: Text(
                        '${index + 1}º',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: getMedalColor(),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        participante.nome,
                        style: const TextStyle(fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: pontuacaoColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$pontuacao pts',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: pontuacaoColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            
            const Divider(height: 24, thickness: 1),
            
            if (ultimo != null)
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '$posicaoUltimoº',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ultimo['participante'].nome,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${ultimo['pontuacao']} pontos',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.warning_amber, color: Colors.red),
                  ],
                ),
              ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }

  Widget _buildProximaRodadaCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              setState(() {
                _expandedProximas = !_expandedProximas;
              });
            },
            leading: const Icon(Icons.calendar_today, color: Color(0xFF0B5D3B)),
            title: const Text(
              'PRÓXIMA RODADA',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Rodada ${_proximaRodada!['numero']} - ${_formatarData(_proximaRodada!['data'])}',
              style: const TextStyle(fontSize: 12),
            ),
            trailing: Icon(
              _expandedProximas ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            ),
          ),
          if (_expandedProximas)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: _proximosJogos.map((jogo) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(jogo['escudoA'], width: 24, height: 24),
                            const SizedBox(width: 8),
                            Text(
                              jogo['timeA'],
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        const Text('vs', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(width: 16),
                        Row(
                          children: [
                            Text(
                              jogo['timeB'],
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(width: 8),
                            SvgPicture.asset(jogo['escudoB'], width: 24, height: 24),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}