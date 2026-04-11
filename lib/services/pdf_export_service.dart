import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class PdfExportService {
  
  /// Gera e compartilha o PDF do ranking
  static Future<void> gerarECompartilharRanking(
    List<Map<String, dynamic>> ranking,
  ) async {
    if (ranking.isEmpty) {
      throw Exception('Nenhum participante para exportar');
    }

    // Criar o PDF com margens reduzidas
    final pdf = pw.Document();
    
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.copyWith(
          marginLeft: 20,
          marginRight: 20,
          marginTop: 30,
          marginBottom: 20,
        ),
        build: (context) {
          return [
            _buildCabecalho(),
            pw.SizedBox(height: 20),
            _buildTabelaRanking(ranking),
          ];
        },
      ),
    );
    
    // Salvar e compartilhar
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/ranking_bolao_2026.pdf');
    await file.writeAsBytes(await pdf.save());
    
    // Compartilhar
    await Share.shareXFiles(
      [XFile(file.path)],
      text: 'Ranking Bolão 2026',
      subject: 'Ranking Bolão 2026',
    );
  }

  static pw.Widget _buildCabecalho() {
    return pw.Column(
      children: [
        pw.Center(
          child: pw.Text(
            'Ranking Bolão 2026',
            style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromHex('#0B5D3B'),
            ),
          ),
        ),
        pw.SizedBox(height: 6),
        pw.Center(
          child: pw.Text(
            _formatarData(DateTime.now()),
            style: pw.TextStyle(fontSize: 10),
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildTabelaRanking(List<Map<String, dynamic>> ranking) {
    return pw.Table(
      border: pw.TableBorder.all(
        width: 0.3,
        color: PdfColor.fromHex('#CCCCCC'),
      ),
      children: [
        // Cabeçalho
        pw.TableRow(
          decoration: pw.BoxDecoration(
            color: PdfColor.fromHex('#0B5D3B'),
          ),
          children: [
            _buildHeaderCell('Pos', width: 30),
            _buildHeaderCell('Participante', flex: true),
            _buildHeaderCell('Pts', width: 35),
          ],
        ),
        // Linhas
        for (var item in ranking)
          pw.TableRow(
            children: [
              _buildDataCell('${item['posicao']}', textAlign: pw.TextAlign.center, width: 30),
              _buildDataCell(item['participante'].nome, flex: true),
              _buildDataCell('${item['pontuacao']}', textAlign: pw.TextAlign.center, width: 35),
            ],
          ),
      ],
    );
  }

  static pw.Widget _buildHeaderCell(String texto, {double? width, bool flex = false}) {
    final child = pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: pw.Text(
        texto,
        style: pw.TextStyle(
          color: PdfColors.white,
          fontWeight: pw.FontWeight.bold,
          fontSize: 11,
        ),
        textAlign: pw.TextAlign.center,
      ),
    );
    
    if (flex) {
      return pw.Flexible(child: child);
    }
    return pw.SizedBox(width: width, child: child);
  }

  static pw.Widget _buildDataCell(String texto, {pw.TextAlign textAlign = pw.TextAlign.left, double? width, bool flex = false}) {
    final child = pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 5, horizontal: 4),
      child: pw.Text(
        texto,
        textAlign: textAlign,
        style: pw.TextStyle(fontSize: 10),
      ),
    );
    
    if (flex) {
      return pw.Flexible(child: child);
    }
    return pw.SizedBox(width: width, child: child);
  }

  static String _formatarData(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}';
  }
}