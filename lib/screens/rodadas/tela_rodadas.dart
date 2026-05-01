import 'package:bolao_/data/rodada_mock.dart';
import 'package:bolao_/database/database_helper.dart';
import 'package:bolao_/models/resultado.dart';
import 'package:bolao_/services/session_service.dart';
import 'package:bolao_/widgets/custom_bottom_bar.dart';
import 'package:bolao_/widgets/menu_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TelaRodadas extends StatefulWidget {
  final VoidCallback onToggleTheme;
  const TelaRodadas({super.key, required this.onToggleTheme});

  @override
  State<TelaRodadas> createState() => _TelaRodadasState();
}

class _TelaRodadasState extends State<TelaRodadas> with AutomaticKeepAliveClientMixin {
  
  @override
  bool get wantKeepAlive => true;

  int selectedIndex = 2;
  int rodadaAtual = 1;
  Map<String, bool> resultadosSalvos = {};
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    _verificarPermissao();
    rodadaAtual = calcularRodadaAtual();
    carregarResultadosSalvos();
    if (isAdmin) {
      adicionarListeners();
    }
  }

  void _verificarPermissao() {
    final usuario = SessionService.getUsuario();
    setState(() {
      isAdmin = usuario?.isAdmin ?? false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  int calcularRodadaAtual() {
    final hoje = DateTime.now();
    final dataHoje = DateTime(hoje.year, hoje.month, hoje.day);
    const int diasVisibilidade = 1; // 👈 1 dia após a data da rodada
    
    for (int i = 0; i < rodadasMock.length; i++) {
      final rodadaData = DateTime.parse(rodadasMock[i].data);
      final dataRodada = DateTime(rodadaData.year, rodadaData.month, rodadaData.day);
      final dataFimVisibilidade = dataRodada.add(Duration(days: diasVisibilidade));
      
      // Se hoje está dentro do período de visibilidade da rodada
      if (!dataHoje.isBefore(dataRodada) && !dataHoje.isAfter(dataFimVisibilidade)) {
        print('📅 Rodada atual (dentro do período): ${rodadasMock[i].numero}');
        return i + 1;
      }
    }
    
    // Se nenhuma rodada estiver no período, mostra a próxima rodada futura
    for (int i = 0; i < rodadasMock.length; i++) {
      final rodadaData = DateTime.parse(rodadasMock[i].data);
      final dataRodada = DateTime(rodadaData.year, rodadaData.month, rodadaData.day);
      
      if (!dataRodada.isBefore(dataHoje)) {
        print('📅 Próxima rodada futura: ${rodadasMock[i].numero}');
        return i + 1;
      }
    }
    
    // Se todas as rodadas já passaram, retorna a última
    print('📅 Última rodada: ${rodadasMock.length}');
    return rodadasMock.length;
  }

  void onBottomBarTap(int index) {
    setState(() => selectedIndex = index);
    
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/menu');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/classificacao');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/ranking');
        break;  
    }
  }

  void proximaRodada() {
    if (rodadaAtual < rodadasMock.length) {
      setState(() {
        rodadaAtual++;
      });
      carregarResultadosSalvos();
      if (isAdmin) {
        adicionarListeners();
      }
    }
  }

  void rodadaAnterior() {
    if (rodadaAtual > 1) {
      setState(() {
        rodadaAtual--;
      });
      carregarResultadosSalvos();
      if (isAdmin) {
        adicionarListeners();
      }
    }
  }

  void _abrirSeletorRodadas() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: 250,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "Selecionar Rodada",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    key: const PageStorageKey('seletor_rodadas'),
                    shrinkWrap: true,
                    itemCount: rodadasMock.length,
                    itemBuilder: (context, index) {
                      final numeroRodada = index + 1;
                      return ListTile(
                        key: ValueKey('rodada_$numeroRodada'),
                        title: Center(
                          child: Text(
                            "Rodada $numeroRodada",
                            style: TextStyle(
                              fontWeight: numeroRodada == rodadaAtual
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: numeroRodada == rodadaAtual
                                  ? Theme.of(context).primaryColor
                                  : null,
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            rodadaAtual = numeroRodada;
                            carregarResultadosSalvos();
                            if (isAdmin) {
                              adicionarListeners();
                            }
                          });
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> carregarResultadosSalvos() async {
    final rodada = rodadasMock[rodadaAtual - 1];
    resultadosSalvos.clear();

    final resultados = await DatabaseHelper.instance
        .buscarResultadosPorRodada(rodada.numero);

    for (var jogo in rodada.jogos) {
      final chave = "${rodada.numero}_${jogo.timeA}_${jogo.timeB}";
      final existe = resultados.any((r) =>
          r.timeA == jogo.timeA &&
          r.timeB == jogo.timeB &&
          r.golsA != null &&
          r.golsB != null);
      resultadosSalvos[chave] = existe;

      if (existe) {
        final r = resultados.firstWhere(
            (res) => res.timeA == jogo.timeA && res.timeB == jogo.timeB);
        jogo.controllerA.text = r.golsA.toString();
        jogo.controllerB.text = r.golsB.toString();
      } else {
        jogo.controllerA.clear();
        jogo.controllerB.clear();
      }
    }
    setState(() {});
  }

  void adicionarListeners() {
    final rodada = rodadasMock[rodadaAtual - 1];
    for (var jogo in rodada.jogos) {
      if (jogo.listenerSalvamento != null) {
        jogo.controllerA.removeListener(jogo.listenerSalvamento!);
        jogo.controllerB.removeListener(jogo.listenerSalvamento!);
      }

      jogo.listenerSalvamento = () {
        if (jogo.controllerA.text.isNotEmpty &&
            jogo.controllerB.text.isNotEmpty) {
          salvarResultadoDoJogo(
              rodada.numero, jogo.timeA, jogo.timeB, jogo.controllerA, jogo.controllerB);
        }
      };

      jogo.controllerA.addListener(jogo.listenerSalvamento!);
      jogo.controllerB.addListener(jogo.listenerSalvamento!);
    }
  }

  Future<void> salvarResultadoDoJogo(
      int rodadaNumero,
      String timeA,
      String timeB,
      TextEditingController controllerA,
      TextEditingController controllerB) async {
    if (controllerA.text.isEmpty || controllerB.text.isEmpty) return;

    final golsA = int.tryParse(controllerA.text) ?? 0;
    final golsB = int.tryParse(controllerB.text) ?? 0;

    final resultadosExistentes = await DatabaseHelper.instance
        .buscarResultadosPorRodada(rodadaNumero);

    final resultadoExistente = resultadosExistentes.firstWhere(
        (r) => r.timeA == timeA && r.timeB == timeB,
        orElse: () => Resultado(
            id: null,
            rodada: rodadaNumero,
            timeA: timeA,
            timeB: timeB,
            golsA: golsA,
            golsB: golsB));

    if (resultadoExistente.id != null) {
      resultadoExistente.golsA = golsA;
      resultadoExistente.golsB = golsB;
      await DatabaseHelper.instance.atualizarResultado(resultadoExistente);
    } else {
      final novoResultado = Resultado(
        rodada: rodadaNumero,
        timeA: timeA,
        timeB: timeB,
        golsA: golsA,
        golsB: golsB,
      );
      await DatabaseHelper.instance.inserirResultados(novoResultado);
    }

    resultadosSalvos["${rodadaNumero}_${timeA}_$timeB"] = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final rodada = rodadasMock[rodadaAtual - 1];
    bool rodadaCompleta = rodada.jogos.every((jogo) =>
        resultadosSalvos["${rodada.numero}_${jogo.timeA}_${jogo.timeB}"] ?? false);

    return Scaffold(
      appBar: MenuAppBar(
        title: 'Rodadas',
        onThemeToggle: widget.onToggleTheme,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // Primeira linha: setas e título centralizado
          Row(
            key: const Key('header_row'),
            children: [
              IconButton(
                key: const Key('btn_anterior'),
                onPressed: rodadaAnterior, 
                icon: const Icon(Icons.arrow_back)
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Rodada ${rodada.numero}",
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              IconButton(
                key: const Key('btn_proxima'),
                onPressed: proximaRodada, 
                icon: const Icon(Icons.arrow_forward)
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Segunda linha: data centralizada e lupa no canto
          Stack(
            alignment: Alignment.center,
            children: [
              // Data centralizada
              Center(
                child: Text(
                  formatarData(rodada.data),
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Lupa no canto direito
              Positioned(
                right: 16,
                child: IconButton(
                  key: const Key('btn_buscar'),
                  onPressed: _abrirSeletorRodadas,
                  icon: const Icon(Icons.search),
                  constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                key: Key('container_rodada_${rodada.numero}'),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: rodadaCompleta
                            ? Colors.green
                            : Colors.grey.withOpacity(0.2),
                        width: 2)),
                child: Column(
                  children: rodada.jogos.asMap().entries.map((entry) {
                    final idx = entry.key;
                    final jogo = entry.value;
                    return Container(
                      key: ValueKey('jogo_${rodada.numero}_$idx'),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SvgPicture.asset(jogo.escudoA, width: 32, height: 32),
                                      const SizedBox(width: 6),
                                      Flexible(
                                        child: Text(
                                          jogo.timeA,
                                          textAlign: TextAlign.right,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .color!
                                                  .withOpacity(0.9)),
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      _buildInput(context, jogo.controllerA, isAdmin),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Text("x",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      _buildInput(context, jogo.controllerB, isAdmin),
                                      const SizedBox(width: 6),
                                      Flexible(
                                        child: Text(
                                          jogo.timeB,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .color!
                                                  .withOpacity(0.9)),
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      SvgPicture.asset(jogo.escudoB, width: 32, height: 32),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (jogo != rodada.jogos.last)
                            Divider(height: 1, color: Colors.grey.withOpacity(0.3)),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
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

  Widget _buildInput(BuildContext context, TextEditingController controller, bool isAdmin) {
    return Container(
      width: 50,
      height: 42,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          readOnly: !isAdmin,
          style: TextStyle(
            fontSize: 18, 
            fontWeight: FontWeight.bold,
            color: !isAdmin ? Colors.grey.shade600 : null,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            isDense: true,
          ),
        ),
      ),
    );
  }

  String formatarData(String dataIso) {
    final data = DateTime.parse(dataIso);
    final dia = data.day.toString().padLeft(2, '0');
    final mes = data.month.toString().padLeft(2, '0');
    final ano = data.year.toString().padLeft(2, '0');
    return "$dia/$mes/$ano";
  }
}