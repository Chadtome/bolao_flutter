import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:bolao_/database/database_helper.dart';
import 'package:bolao_/models/participante.dart';
import 'package:bolao_/models/time.dart';
import 'package:bolao_/data/times_data.dart';
import 'package:bolao_/services/session_service.dart';
import 'package:bolao_/services/time_control_service.dart';
import 'package:bolao_/theme/app_colors.dart';
import 'package:bolao_/widgets/custom_appbar.dart';
import 'package:bolao_/widgets/toast.widget.dart';
import 'package:open_file/open_file.dart';

class ListaParticipantesScreen extends StatefulWidget {
  final VoidCallback? onToggleTheme;
  const ListaParticipantesScreen({super.key, this.onToggleTheme});

  @override
  State<ListaParticipantesScreen> createState() =>
      _ListaParticipantesScreenState();
}

class _ListaParticipantesScreenState extends State<ListaParticipantesScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Participante> participantesFiltrados = [];
  List<Participante> participantes = [];

  @override
  void initState() {
    super.initState();
    _carregarParticipantes();

    _searchController.addListener(() {
      _filtrarParticipantes();
    });
  }

  Future<void> _carregarParticipantes() async {
    final dados = await DatabaseHelper.instance.buscarParticipantes();
    setState(() {
      participantes = dados;
      participantesFiltrados = dados;
    });
  }

  // ---------------- GERAR PDF -----------------------
  Future<pw.Document> gerarPdf() async {
    final pdf = pw.Document();

    for (var i = 0; i < participantes.length; i += 16) {
      final slice = participantes.skip(i).take(16).toList();

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return [
              pw.Text(
                'Bolão 2026',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColor.fromHex('#388E3C'),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Table(
                border: pw.TableBorder.all(
                  width: 0.5,
                  color: PdfColor.fromHex('#CCCCCC'),
                ),
                children: [
                  for (var row = 0; row < 4; row++)
                    pw.TableRow(
                      children: [
                        for (var col = 0; col < 4; col++)
                          if (row * 4 + col < slice.length)
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  slice[row * 4 + col].nome,
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                pw.SizedBox(height: 4),
                                ...slice[row * 4 + col].grupos.entries.expand(
                                      (e) => e.value.map((id) {
                                        final time = timesData.firstWhere(
                                          (t) => t.id == id,
                                          orElse: () => Time(
                                              id: 0,
                                              nome: 'Desconhecido',
                                              grupoId: 0,
                                              logo: '',
                                              abreviatura: ''),
                                        );
                                        return pw.Text(
                                          '- ${time.nome}',
                                          style: pw.TextStyle(fontSize: 10),
                                        );
                                      }),
                                    ),
                              ],
                            )
                          else
                            pw.SizedBox(),
                      ],
                    ),
                ],
              ),
            ];
          },
        ),
      );
    }

    return pdf;
  }

  // ---------------- SALVAR PDF -----------------------

  Future<void> salvarPdfEPDFabrir(pw.Document pdf, String nomeArquivo, BuildContext context) async {
    try {
      Directory dir;

      if (Platform.isAndroid) {
        final dirs = await getExternalStorageDirectories(type: StorageDirectory.downloads);
        if (dirs == null || dirs.isEmpty) throw 'Não foi possível acessar a pasta Downloads';
        dir = dirs.first;
      } else if (Platform.isIOS) {
        dir = await getApplicationDocumentsDirectory();
      } else {
        dir = await getApplicationDocumentsDirectory();
      }

      final file = File('${dir.path}/$nomeArquivo.pdf');
      await file.writeAsBytes(await pdf.save());

      await OpenFile.open(file.path);

      AppToast.success(context: context, text: 'PDF salvo e aberto!');
    } catch (e) {
      print('❌ Erro ao salvar ou abrir PDF: $e');
      AppToast.error(context: context, text: 'Erro ao salvar ou abrir PDF');
    }
  }

  // ------------------- FILTRAR PARTICIPANTE --------------------------

  void _filtrarParticipantes() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      if (query.isEmpty) {
        participantesFiltrados = participantes;
      } else {
        participantesFiltrados = participantes
            .where((p) => p.nome.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  // ---------------- BUILD -----------------------
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final buttonColor = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final highlightColor = isDark ? AppColors.darkAccent : AppColors.lightAccent;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Participantes Cadastrados',
        onThemeToggle: widget.onToggleTheme,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar participante',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)
                ),
              ),
            ),
          ),
          Expanded(
            child: participantesFiltrados.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          size: 48,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Nenhum participante encontrado',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600]
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: participantesFiltrados.length,
                    itemBuilder: (context, index) {
                      final p = participantesFiltrados[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                        child: Slidable(
                          key: ValueKey(p.id),
                          endActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            children: [
                              // 👉 BOTÃO EDITAR COM VERIFICAÇÃO DE PRAZO
                              SlidableAction(
                                onPressed: (context) async {
                                  final usuarioLogado = SessionService.getUsuario();
                                  
                                  // Admin sempre pode editar
                                  if (usuarioLogado != null && usuarioLogado.isAdmin) {
                                    Navigator.pushNamed(
                                      context,
                                      '/novo_participante',
                                      arguments: p,
                                    ).then((_) => _carregarParticipantes());
                                    return;
                                  }
                                  
                                  // Usuário comum: verificar prazo
                                  if (!TimeControlService.podeEditar()) {
                                    AppToast.error(
                                      context: context,
                                      text: TimeControlService.getMensagemBloqueioEdicao()!,
                                    );
                                    return;
                                  }
                                  
                                  Navigator.pushNamed(
                                    context,
                                    '/novo_participante',
                                    arguments: p,
                                  ).then((_) => _carregarParticipantes());
                                },
                                backgroundColor: buttonColor,
                                foregroundColor: Colors.white,
                                icon: Icons.edit,
                                label: 'Editar',
                              ),
                              SlidableAction(
  onPressed: (_) async {
    final usuarioLogado = SessionService.getUsuario();
    
    // Verificar se é admin
    if (usuarioLogado == null || !usuarioLogado.isAdmin) {
      AppToast.error(
        context: context,
        text: 'Apenas administradores podem excluir participantes.',
      );
      return;
    }
    
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirmar exclusão"),
        content: Text('Deseja excluir ${p.nome}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Excluir"),
          ),
        ],
      ),
    );

    if (confirmar == true) {
      await DatabaseHelper.instance.deletarParticipante(p.id!);
      await _carregarParticipantes();
      AppToast.success(
        context: context,
        text: 'Participante "${p.nome}" excluído com sucesso',
      );
    }
  },
  backgroundColor: Colors.red.shade400,
  foregroundColor: Colors.white,
  icon: Icons.delete,
  label: 'Excluir',
),

                            ],
                          ),
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: highlightColor, width: 1.5),
                            ),
                            child: ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                              dense: true,
                              visualDensity: VisualDensity.compact,
                              title: Text(
                                p.nome,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                              onTap: () {
                                final List<String> times = [];
                                p.grupos.forEach((grupo, ids) {
                                  for (var id in ids) {
                                    final time = timesData.firstWhere(
                                      (t) => t.id == id,
                                      orElse: () => Time(
                                        id: 0,
                                        nome: 'Desconhecido', 
                                        grupoId: 0,
                                        logo: '',
                                        abreviatura: '',
                                      ),
                                    );
                                    times.add(time.nome);
                                  }
                                });
                                showModalBottomSheet(
                                  context: context, 
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.vertical(top: Radius.circular(16))
                                  ),
                                  backgroundColor: Theme.of(context).colorScheme.surface,
                                  builder: (context) {
                                    return Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            p.nome,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          if (times.isNotEmpty)
                                            ...times.map((time) => Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 4),
                                              child: Text(
                                                time,
                                                style: const TextStyle(fontSize: 16),
                                              ),
                                            ))
                                          else
                                            const Text(
                                              "Nenhum time selecionado",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          const SizedBox(height: 16),
                                          Align(
                                            alignment: AlignmentGeometry.centerRight,
                                            child: TextButton(
                                              onPressed: () => Navigator.pop(context), 
                                              child: const Text("Fechar")
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 6,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '${participantes.length} participantes cadastrados',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  final pdf = await gerarPdf();
                  await salvarPdfEPDFabrir(pdf, 'Bolao2026', context);
                },
                icon: const Icon(Icons.picture_as_pdf, size: 18),
                label: const Text("Exportar"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}