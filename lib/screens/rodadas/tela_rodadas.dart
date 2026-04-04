import 'package:bolao_/data/rodada_mock.dart';
import 'package:bolao_/database/database_helper.dart';
import 'package:bolao_/models/resultado.dart';
import 'package:bolao_/widgets/custom_appbar.dart';
import 'package:bolao_/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TelaRodadas extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const TelaRodadas({super.key, required this.onToggleTheme});

  @override
  State<TelaRodadas> createState() => _TelaRodadasState();
}

class _TelaRodadasState extends State<TelaRodadas> {
  int selectedIndex = 2;
  int rodadaAtual = 1;

  //---------------------------------------------------
  Map<String, bool> resultadosSalvos = {};

  int calcularRodadaAtual() {
    final agora = DateTime.now();
    final hoje = DateTime(agora.year, agora.month, agora.day);

    for (int i = 0; i < rodadasMock.length; i++) {
      final rodadaData = DateTime.parse(rodadasMock[i].data);

      if (!rodadaData.isBefore(hoje)) {
        return i + 1;
      }
    }
    return rodadasMock.length;
  }

  //---------------------------------------------------
  void onBottomBarTap(int index) {
    setState(() {
      selectedIndex = index;
    });

    if (index == 1) {
      Navigator.pushNamed(context, '/menu');
    }
  }

  void proximaRodada() {
    if (rodadaAtual < rodadasMock.length) {
      setState(() {
        rodadaAtual++;
      });
      carregarResultadosSalvos();
      adicionarListeners();
    }
  }

  void rodadaAnterior() {
    if (rodadaAtual > 1) {
      setState(() {
        rodadaAtual--;
      });
      carregarResultadosSalvos();
      adicionarListeners();
    }
  }

  //-----------------------------------------------------
  @override
  void initState() {
    super.initState();
    rodadaAtual = calcularRodadaAtual();
    carregarResultadosSalvos();
    adicionarListeners();
  }

  //-----------------------------------------------------
  Future<void> carregarResultadosSalvos() async {
    final rodada = rodadasMock[(rodadaAtual - 1).clamp(0, rodadasMock.length - 1)];

    resultadosSalvos.clear();

    final resultados = await DatabaseHelper.instance.buscarResultadosPorRodada(rodada.numero);

    for (var jogo in rodada.jogos) {
      final chave = "${rodada.numero}_${jogo.timeA}_${jogo.timeB}";
      final existe = resultados.any((r) =>
          r.timeA == jogo.timeA &&
          r.timeB == jogo.timeB &&
          r.golsA != null &&
          r.golsB != null);
      resultadosSalvos[chave] = existe;

      // Preenche os controllers com os valores salvos
      if (existe) {
        final r = resultados.firstWhere((res) =>
            res.timeA == jogo.timeA && res.timeB == jogo.timeB);
        jogo.controllerA.text = r.golsA.toString();
        jogo.controllerB.text = r.golsB.toString();
      }
    }
    setState(() {});
  }

  //-----------------------------------------------------
  void adicionarListeners() {
    final rodada = rodadasMock[(rodadaAtual - 1).clamp(0, rodadasMock.length - 1)];
    for (var jogo in rodada.jogos) {
      jogo.controllerA.removeListener(salvarResultadosAutomatico);
      jogo.controllerB.removeListener(salvarResultadosAutomatico);

      jogo.controllerA.addListener(salvarResultadosAutomatico);
      jogo.controllerB.addListener(salvarResultadosAutomatico);
    }
  }

  Future<void> salvarResultadosAutomatico() async {
  final rodada = rodadasMock[(rodadaAtual - 1).clamp(0, rodadasMock.length - 1)];

  bool todosPreenchidos = rodada.jogos.every((jogo) =>
      jogo.controllerA.text.isNotEmpty && jogo.controllerB.text.isNotEmpty);

  if (!todosPreenchidos) return; // Não salva se algum campo estiver vazio

  for (var jogo in rodada.jogos) {
    final chave = "${rodada.numero}_${jogo.timeA}_${jogo.timeB}";
    final golsA = int.tryParse(jogo.controllerA.text) ?? 0;
    final golsB = int.tryParse(jogo.controllerB.text) ?? 0;

    // Verifica se já existe no banco
    final resultadosExistentes = await DatabaseHelper.instance
        .buscarResultadosPorRodada(rodada.numero);

    final resultadoExistente = resultadosExistentes.firstWhere(
        (r) => r.timeA == jogo.timeA && r.timeB == jogo.timeB,
        orElse: () => Resultado(
              id: null,
              rodada: rodada.numero,
              timeA: jogo.timeA,
              timeB: jogo.timeB,
              golsA: golsA,
              golsB: golsB,
            ));

    if (resultadoExistente.id != null) {
      // Atualiza resultado existente
      resultadoExistente.golsA = golsA;
      resultadoExistente.golsB = golsB;
      await DatabaseHelper.instance.atualizarResultado(resultadoExistente);
    } else {
      // Insere novo resultado
      final novoResultado = Resultado(
        rodada: rodada.numero,
        timeA: jogo.timeA,
        timeB: jogo.timeB,
        golsA: golsA,
        golsB: golsB,
      );
      await DatabaseHelper.instance.inserirResultados(novoResultado);
    }

    resultadosSalvos[chave] = true;
    print("✅ Resultado salvo/atualizado: Rodada ${rodada.numero} - ${jogo.timeA} $golsA x $golsB ${jogo.timeB}");
  }

  setState(() {}); // Atualiza UI
}

  //-----------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final rodada = rodadasMock[(rodadaAtual - 1).clamp(0, rodadasMock.length - 1)];

    bool rodadaCompleta = rodada.jogos.every((jogo) {
      final chave = "${rodada.numero}_${jogo.timeA}_${jogo.timeB}";
      return resultadosSalvos[chave] ?? false;
    });

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Rodadas',
        onThemeToggle: widget.onToggleTheme,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // 🔹 Navegação da rodada
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: rodadaAnterior,
                icon: const Icon(Icons.arrow_back),
              ),
              Row(
                children: [
                  Text(
                    "Rodada ${rodada.numero}",
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 6),
                  if (rodadaCompleta)
                    const Icon(Icons.check, color: Colors.green),
                ],
              ),
              IconButton(
                onPressed: proximaRodada,
                icon: const Icon(Icons.arrow_forward),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            formatarData(rodada.data),
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          // 🔹 Lista de jogos
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: rodadaCompleta
                        ? Colors.green
                        : Colors.grey.withOpacity(0.2),
                    width: 2,
                  ),
                ),
                child: Column(
                  children: rodada.jogos.map((jogo) {
                    //final chave = "${rodada.numero}_${jogo.timeA}_${jogo.timeB}";
                    //final jogoSalvo = resultadosSalvos[chave] ?? false;

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                          child: Row(
                            children: [
                              // 🔹 Time A: logo + nome + input
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SvgPicture.asset(
                                      jogo.escudoA,
                                      width: 32,
                                      height: 32,
                                    ),
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
                                              .withOpacity(0.9),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    _buildInput(context, jogo.controllerA),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                "x",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    _buildInput(context, jogo.controllerB),
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
                                              .withOpacity(0.9),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    SvgPicture.asset(
                                      jogo.escudoB,
                                      width: 32,
                                      height: 32,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (jogo != rodada.jogos.last)
                          Divider(
                            height: 1,
                            color: Colors.grey.withOpacity(0.3),
                          ),
                      ],
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

  Widget _buildInput(BuildContext context, TextEditingController controller) {
    return SizedBox(
      width: 50,
      height: 42,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.surfaceVariant,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }

  //---------------- TRANSFORMANDO A DATA PARA MOSTRAR NA TELA ----------------
  String formatarData(String dataIso) {
    final data = DateTime.parse(dataIso);
    final dia = data.day.toString().padLeft(2, '0');
    final mes = data.month.toString().padLeft(2, '0');
    final ano = data.year.toString().padLeft(2, '0');

    return "$dia/$mes/$ano";
  }
}