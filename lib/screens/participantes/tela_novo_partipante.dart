//------------------------------------------------------------------------------------------------
// import 'package:bolao_/models/participante.dart';
// import 'package:bolao_/models/time.dart';
// import 'package:bolao_/widgets/custom_appbar.dart';
// import 'package:bolao_/widgets/custom_checkbox_option.dart';
// import 'package:bolao_/widgets/toast.widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// // Dados dos times
// import 'package:bolao_/data/times_data.dart';
// import 'package:bolao_/database/database_helper.dart';

// class TelaNovoParticipante extends StatefulWidget {
//   final VoidCallback onToggleTheme;
//   const TelaNovoParticipante({super.key, required this.onToggleTheme});

//   @override
//   State<TelaNovoParticipante> createState() => _TelaNovoParticipanteState();
// }

// class _TelaNovoParticipanteState extends State<TelaNovoParticipante> {
//   final TextEditingController nomeController = TextEditingController();
//   Participante? participanteEdicao;
//   bool isEdicao = false;

//   bool erroNome = false;

//   final Map<String, int> gruposLimite = {
//     'Grupo 1': 1,
//     'Grupo 2': 2,
//     'Grupo 3': 1,
//     'Grupo 4': 2,
//     'Grupo 5': 2,
//     'Grupo 6': 2,
//   };

//   final Map<String, List<int>> gruposSelecionados = {
//     'Grupo 1': [],
//     'Grupo 2': [],
//     'Grupo 3': [],
//     'Grupo 4': [],
//     'Grupo 5': [],
//     'Grupo 6': [],
//   };

//   Map<String, bool> erroGrupo = {
//     'Grupo 1': false,
//     'Grupo 2': false,
//     'Grupo 3': false,
//     'Grupo 4': false,
//     'Grupo 5': false,
//     'Grupo 6': false,
//   };

//   bool temErroGrupos() => erroGrupo.values.any((erro) => erro == true);

//   int totalTimesSelecionados() {
//     int total = 0;
//     gruposSelecionados.values.forEach((list) => total += list.length);
//     return total;
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();

//     final args = ModalRoute.of(context)?.settings.arguments;

//     if (args != null && args is Participante && !isEdicao) {
//       participanteEdicao = args;
//       isEdicao = true;

//       nomeController.text = participanteEdicao!.nome;

//       participanteEdicao!.grupos.forEach((grupo, lista) {
//         gruposSelecionados[grupo] = List<int>.from(lista);
//       });
//     }
//   }

//   // 👉 NOVO: Diálogo para digitar a senha
//   Future<String?> _mostrarDialogSenha() async {
//     final senhaController = TextEditingController();
    
//     return showDialog<String>(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Cadastro de Acesso'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text('Defina uma senha para o participante poder acessar o app:'),
//               const SizedBox(height: 16),
//               TextField(
//                 controller: senhaController,
//                 obscureText: true,
//                 decoration: const InputDecoration(
//                   labelText: 'Senha',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context, null),
//               child: const Text('Cancelar'),
//             ),
//             TextButton(
//               onPressed: () {
//                 if (senhaController.text.trim().isNotEmpty) {
//                   Navigator.pop(context, senhaController.text.trim());
//                 }
//               },
//               child: const Text('Salvar'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> salvarParticipante() async {
//     bool temErro = false;

//     setState(() {
//       erroNome = nomeController.text.trim().isEmpty;

//       gruposLimite.forEach((grupo, limite) {
//         if (gruposSelecionados[grupo]!.length != limite) {
//           erroGrupo[grupo] = true;
//           temErro = true;
//         } else {
//           erroGrupo[grupo] = false;
//         }
//       });
//     });

//     if (erroNome || temErro) {
//       AppToast.error(
//         context: context,
//         text: 'Ainda existem campos para preencher',
//       );
//       return;
//     }

//     final participante = Participante(
//       id: participanteEdicao?.id,
//       nome: nomeController.text.trim(),
//       grupos: gruposSelecionados,
//     );

//     if (isEdicao) {
//       // Edição: apenas atualiza participante
//       await DatabaseHelper.instance.atualizarParticipante(participante);
      
//       AppToast.success(
//         context: context,
//         text: 'Participante atualizado com sucesso',
//       );
//     } else {
//       // 👉 NOVO: Cadastro com senha
//       final senha = await _mostrarDialogSenha();
//       if (senha == null) return; // Usuário cancelou
      
//       await DatabaseHelper.instance.inserirParticipanteComUsuario(participante, senha);
      
//       final login = participante.nome.toLowerCase().replaceAll(' ', '_');
//       AppToast.success(
//         context: context,
//         text: 'Participante salvo! Login: $login | Senha: $senha',
//       );
//     }

//     // Mostrar todos os participantes no console
//     final participantes = await DatabaseHelper.instance.buscarParticipantes();
//     print('----------------------------------');
//     print('Lista de Participantes:');
//     for (var p in participantes) {
//       List<String> nomesTimes = [];
//       p.grupos.forEach((grupo, idsTimes) {
//         for (var id in idsTimes) {
//           final time = timesData.firstWhere(
//             (t) => t.id == id,
//             orElse: () =>
//                 Time(id: 0, nome: 'Desconhecido', grupoId: 0, logo: '', abreviatura: ''),
//           );
//           nomesTimes.add(time.nome);
//         }
//       });
//       print('ID: ${p.id}, Nome: ${p.nome}, Times escolhidos: $nomesTimes');
//     }
//     print('----------------------------------');

//     // Limpar campos
//     setState(() {
//       nomeController.clear();
//       gruposSelecionados.forEach((key, value) => value.clear());
//       erroGrupo.forEach((key, value) => erroGrupo[key] = false);
//       participanteEdicao = null;
//       isEdicao = false;
//     });

//     // Voltar para lista
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     final textTheme = Theme.of(context).textTheme;

//     return Scaffold(
//       backgroundColor: colorScheme.background,
//       appBar: CustomAppBar(
//         title: isEdicao ? 'Editar Participante' : 'Novo Participante',
//         onThemeToggle: widget.onToggleTheme,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // Nome do participante
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextField(
//                   controller: nomeController,
//                   onChanged: (value) {
//                     if (erroNome && value.trim().isNotEmpty) {
//                       setState(() {
//                         erroNome = false;
//                       });
//                     }
//                   },
//                   decoration: InputDecoration(
//                     labelText: 'Nome do participante',
//                     contentPadding:
//                         const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
//                     enabledBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(
//                         color: erroNome ? Colors.red : const Color(0XFFCDCDCD),
//                         width: 1.5,
//                       ),
//                     ),
//                     focusedBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(
//                         color: erroNome ? Colors.red : const Color(0XFF0B5D3B),
//                         width: 1.5,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 24),

//             // Container de grupos: Times escolhidos
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(16),
//               margin: const EdgeInsets.only(bottom: 16),
//               decoration: BoxDecoration(
//                 color: colorScheme.surface,
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(
//                   color: temErroGrupos() ? Colors.red : colorScheme.secondary,
//                   width: 1.5,
//                 ),
//               ),
//               child: Text(
//                 'Grupos: Times escolhidos: ${totalTimesSelecionados()}/10',
//                 style: textTheme.bodyLarge?.copyWith(
//                   fontWeight: FontWeight.bold,
//                   color: colorScheme.onSurface,
//                 ),
//               ),
//             ),

//             // Grupos expansíveis
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: gruposLimite.keys.map((grupo) {
//                     final timesDoGrupo = timesData
//                         .where((t) =>
//                             t.grupoId == int.parse(grupo.split(' ')[1]))
//                         .toList();

//                     return Container(
//                       width: double.infinity,
//                       margin: const EdgeInsets.only(bottom: 16),
//                       decoration: BoxDecoration(
//                         color: colorScheme.surface,
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(
//                           color: erroGrupo[grupo]!
//                               ? Colors.red
//                               : colorScheme.secondary,
//                           width: 1.5,
//                         ),
//                       ),
//                       child: Theme(
//                         data: Theme.of(context)
//                             .copyWith(dividerColor: Colors.transparent),
//                         child: ExpansionTile(
//                           title: Text(
//                             '$grupo - Escolher ${gruposLimite[grupo] == 1 ? "apenas 1" : gruposLimite[grupo]}',
//                             style: textTheme.bodyLarge?.copyWith(
//                               fontWeight: FontWeight.bold,
//                               color: colorScheme.onSurface,
//                             ),
//                           ),
//                           tilePadding:
//                               const EdgeInsets.symmetric(horizontal: 8),
//                           childrenPadding: const EdgeInsets.symmetric(
//                               horizontal: 16, vertical: 4),
//                           children: [
//                             for (var time in timesDoGrupo) ...[
//                               CustomCheckboxOption(
//                                 isSelected:
//                                     gruposSelecionados[grupo]!.contains(time.id),
//                                 onChanged: (val) {
//                                   final limiteAtingido =
//                                       gruposSelecionados[grupo]!.length >=
//                                           gruposLimite[grupo]!;

//                                   if (limiteAtingido &&
//                                       !gruposSelecionados[grupo]!
//                                           .contains(time.id)) {
//                                     final limite = gruposLimite[grupo];
//                                     AppToast.error(
//                                       context: context,
//                                       text:
//                                           '$grupo permite apenas $limite ${limite == 1 ? "time" : "times"}',
//                                     );
//                                     return;
//                                   }

//                                   setState(() {
//                                     if (val == true) {
//                                       gruposSelecionados[grupo]!.add(time.id!);
//                                     } else {
//                                       gruposSelecionados[grupo]!.remove(time.id!);
//                                     }

//                                     if (gruposSelecionados[grupo]!.length ==
//                                         gruposLimite[grupo]) {
//                                       erroGrupo[grupo] = false;
//                                     }
//                                   });
//                                 },
//                                 child: Row(
//                                   children: [
//                                     SvgPicture.asset(
//                                       time.logo!,
//                                       width: 24,
//                                       height: 24,
//                                     ),
//                                     const SizedBox(width: 8),
//                                     Text(
//                                       time.nome,
//                                       style: textTheme.bodyMedium?.copyWith(
//                                         color: colorScheme.onSurface,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               Divider(
//                                 height: 1.5,
//                                 color:
//                                     colorScheme.onSurface.withOpacity(0.05),
//                               ),
//                               const SizedBox(height: 8),
//                             ],
//                           ],
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),

//       // BottomBar fixo com botão Salvar
//       bottomNavigationBar: BottomAppBar(
//         color: colorScheme.surface,
//         elevation: 4,
//         child: SizedBox(
//           height: 50,
//           child: Padding(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: colorScheme.primary,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               onPressed: salvarParticipante,
//               child: const Center(
//                 child: Text(
//                   'Salvar',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:bolao_/models/participante.dart';
// import 'package:bolao_/models/time.dart';
// import 'package:bolao_/services/session_service.dart';
// import 'package:bolao_/widgets/custom_appbar.dart';
// import 'package:bolao_/widgets/custom_checkbox_option.dart';
// import 'package:bolao_/widgets/toast.widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// // Dados dos times
// import 'package:bolao_/data/times_data.dart';
// import 'package:bolao_/database/database_helper.dart';

// class TelaNovoParticipante extends StatefulWidget {
//   final VoidCallback onToggleTheme;
//   const TelaNovoParticipante({super.key, required this.onToggleTheme});

//   @override
//   State<TelaNovoParticipante> createState() => _TelaNovoParticipanteState();
// }

// class _TelaNovoParticipanteState extends State<TelaNovoParticipante> {
//   final TextEditingController nomeController = TextEditingController();
//   Participante? participanteEdicao;
//   bool isEdicao = false;

//   bool erroNome = false;

//   final Map<String, int> gruposLimite = {
//     'Grupo 1': 1,
//     'Grupo 2': 2,
//     'Grupo 3': 1,
//     'Grupo 4': 2,
//     'Grupo 5': 2,
//     'Grupo 6': 2,
//   };

//   final Map<String, List<int>> gruposSelecionados = {
//     'Grupo 1': [],
//     'Grupo 2': [],
//     'Grupo 3': [],
//     'Grupo 4': [],
//     'Grupo 5': [],
//     'Grupo 6': [],
//   };

//   Map<String, bool> erroGrupo = {
//     'Grupo 1': false,
//     'Grupo 2': false,
//     'Grupo 3': false,
//     'Grupo 4': false,
//     'Grupo 5': false,
//     'Grupo 6': false,
//   };

//   bool temErroGrupos() => erroGrupo.values.any((erro) => erro == true);

//   int totalTimesSelecionados() {
//     int total = 0;
//     gruposSelecionados.values.forEach((list) => total += list.length);
//     return total;
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();

//     final args = ModalRoute.of(context)?.settings.arguments;

//     if (args != null && args is Participante && !isEdicao) {
//       participanteEdicao = args;
//       isEdicao = true;

//       nomeController.text = participanteEdicao!.nome;

//       participanteEdicao!.grupos.forEach((grupo, lista) {
//         gruposSelecionados[grupo] = List<int>.from(lista);
//       });
//     }
//   }

//   Future<void> salvarParticipante() async {
//     bool temErro = false;

//     setState(() {
//       erroNome = nomeController.text.trim().isEmpty;

//       gruposLimite.forEach((grupo, limite) {
//         if (gruposSelecionados[grupo]!.length != limite) {
//           erroGrupo[grupo] = true;
//           temErro = true;
//         } else {
//           erroGrupo[grupo] = false;
//         }
//       });
//     });

//     if (erroNome || temErro) {
//       AppToast.error(
//         context: context,
//         text: 'Ainda existem campos para preencher',
//       );
//       return;
//     }

//     final participante = Participante(
//       id: participanteEdicao?.id,
//       nome: nomeController.text.trim(),
//       grupos: gruposSelecionados,
//     );

//     if (isEdicao) {
//       // Edição: apenas atualiza participante
//       await DatabaseHelper.instance.atualizarParticipante(participante);
      
//       AppToast.success(
//         context: context,
//         text: 'Participante atualizado com sucesso',
//       );
//     } else {
//       // Verificar se tem usuário logado
//       final usuarioLogado = SessionService.getUsuario();
      
//       if (usuarioLogado == null) {
//         AppToast.error(
//           context: context,
//           text: 'Erro: nenhum usuário logado. Faça login novamente.',
//         );
//         return;
//       }
      
//       // Insere participante e vincula ao usuário logado
//       await DatabaseHelper.instance.inserirParticipanteParaUsuario(
//         participante,
//         usuarioLogado.id!,
//       );
      
//       AppToast.success(
//         context: context,
//         text: 'Participante cadastrado com sucesso!',
//       );
//     }

//     // Mostrar todos os participantes no console
//     final participantes = await DatabaseHelper.instance.buscarParticipantes();
//     print('----------------------------------');
//     print('Lista de Participantes:');
//     for (var p in participantes) {
//       List<String> nomesTimes = [];
//       p.grupos.forEach((grupo, idsTimes) {
//         for (var id in idsTimes) {
//           final time = timesData.firstWhere(
//             (t) => t.id == id,
//             orElse: () =>
//                 Time(id: 0, nome: 'Desconhecido', grupoId: 0, logo: '', abreviatura: ''),
//           );
//           nomesTimes.add(time.nome);
//         }
//       });
//       print('ID: ${p.id}, Nome: ${p.nome}, Times escolhidos: $nomesTimes');
//     }
//     print('----------------------------------');

//     // Limpar campos
//     setState(() {
//       nomeController.clear();
//       gruposSelecionados.forEach((key, value) => value.clear());
//       erroGrupo.forEach((key, value) => erroGrupo[key] = false);
//       participanteEdicao = null;
//       isEdicao = false;
//     });

//     // Voltar para lista
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     final textTheme = Theme.of(context).textTheme;

//     return Scaffold(
//       backgroundColor: colorScheme.background,
//       appBar: CustomAppBar(
//         title: isEdicao ? 'Editar Participante' : 'Novo Participante',
//         onThemeToggle: widget.onToggleTheme,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // Nome do participante
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextField(
//                   controller: nomeController,
//                   onChanged: (value) {
//                     if (erroNome && value.trim().isNotEmpty) {
//                       setState(() {
//                         erroNome = false;
//                       });
//                     }
//                   },
//                   decoration: InputDecoration(
//                     labelText: 'Nome do participante',
//                     contentPadding:
//                         const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
//                     enabledBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(
//                         color: erroNome ? Colors.red : const Color(0XFFCDCDCD),
//                         width: 1.5,
//                       ),
//                     ),
//                     focusedBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(
//                         color: erroNome ? Colors.red : const Color(0XFF0B5D3B),
//                         width: 1.5,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 24),

//             // Container de grupos: Times escolhidos
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(16),
//               margin: const EdgeInsets.only(bottom: 16),
//               decoration: BoxDecoration(
//                 color: colorScheme.surface,
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(
//                   color: temErroGrupos() ? Colors.red : colorScheme.secondary,
//                   width: 1.5,
//                 ),
//               ),
//               child: Text(
//                 'Grupos: Times escolhidos: ${totalTimesSelecionados()}/10',
//                 style: textTheme.bodyLarge?.copyWith(
//                   fontWeight: FontWeight.bold,
//                   color: colorScheme.onSurface,
//                 ),
//               ),
//             ),

//             // Grupos expansíveis
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: gruposLimite.keys.map((grupo) {
//                     final timesDoGrupo = timesData
//                         .where((t) =>
//                             t.grupoId == int.parse(grupo.split(' ')[1]))
//                         .toList();

//                     return Container(
//                       width: double.infinity,
//                       margin: const EdgeInsets.only(bottom: 16),
//                       decoration: BoxDecoration(
//                         color: colorScheme.surface,
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(
//                           color: erroGrupo[grupo]!
//                               ? Colors.red
//                               : colorScheme.secondary,
//                           width: 1.5,
//                         ),
//                       ),
//                       child: Theme(
//                         data: Theme.of(context)
//                             .copyWith(dividerColor: Colors.transparent),
//                         child: ExpansionTile(
//                           title: Text(
//                             '$grupo - Escolher ${gruposLimite[grupo] == 1 ? "apenas 1" : gruposLimite[grupo]}',
//                             style: textTheme.bodyLarge?.copyWith(
//                               fontWeight: FontWeight.bold,
//                               color: colorScheme.onSurface,
//                             ),
//                           ),
//                           tilePadding:
//                               const EdgeInsets.symmetric(horizontal: 8),
//                           childrenPadding: const EdgeInsets.symmetric(
//                               horizontal: 16, vertical: 4),
//                           children: [
//                             for (var time in timesDoGrupo) ...[
//                               CustomCheckboxOption(
//                                 isSelected:
//                                     gruposSelecionados[grupo]!.contains(time.id),
//                                 onChanged: (val) {
//                                   final limiteAtingido =
//                                       gruposSelecionados[grupo]!.length >=
//                                           gruposLimite[grupo]!;

//                                   if (limiteAtingido &&
//                                       !gruposSelecionados[grupo]!
//                                           .contains(time.id)) {
//                                     final limite = gruposLimite[grupo];
//                                     AppToast.error(
//                                       context: context,
//                                       text:
//                                           '$grupo permite apenas $limite ${limite == 1 ? "time" : "times"}',
//                                     );
//                                     return;
//                                   }

//                                   setState(() {
//                                     if (val == true) {
//                                       gruposSelecionados[grupo]!.add(time.id!);
//                                     } else {
//                                       gruposSelecionados[grupo]!.remove(time.id!);
//                                     }

//                                     if (gruposSelecionados[grupo]!.length ==
//                                         gruposLimite[grupo]) {
//                                       erroGrupo[grupo] = false;
//                                     }
//                                   });
//                                 },
//                                 child: Row(
//                                   children: [
//                                     SvgPicture.asset(
//                                       time.logo!,
//                                       width: 24,
//                                       height: 24,
//                                     ),
//                                     const SizedBox(width: 8),
//                                     Text(
//                                       time.nome,
//                                       style: textTheme.bodyMedium?.copyWith(
//                                         color: colorScheme.onSurface,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               Divider(
//                                 height: 1.5,
//                                 color:
//                                     colorScheme.onSurface.withOpacity(0.05),
//                               ),
//                               const SizedBox(height: 8),
//                             ],
//                           ],
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),

//       // BottomBar fixo com botão Salvar
//       bottomNavigationBar: BottomAppBar(
//         color: colorScheme.surface,
//         elevation: 4,
//         child: SizedBox(
//           height: 50,
//           child: Padding(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: colorScheme.primary,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               onPressed: salvarParticipante,
//               child: const Center(
//                 child: Text(
//                   'Salvar',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:bolao_/models/participante.dart';
import 'package:bolao_/models/time.dart';
import 'package:bolao_/services/session_service.dart';
import 'package:bolao_/widgets/custom_appbar.dart';
import 'package:bolao_/widgets/custom_checkbox_option.dart';
import 'package:bolao_/widgets/toast.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Dados dos times
import 'package:bolao_/data/times_data.dart';
import 'package:bolao_/database/database_helper.dart';

class TelaNovoParticipante extends StatefulWidget {
  final VoidCallback onToggleTheme;
  const TelaNovoParticipante({super.key, required this.onToggleTheme});

  @override
  State<TelaNovoParticipante> createState() => _TelaNovoParticipanteState();
}

class _TelaNovoParticipanteState extends State<TelaNovoParticipante> {
  final TextEditingController nomeController = TextEditingController();
  Participante? participanteEdicao;
  bool isEdicao = false;

  bool erroNome = false;

  final Map<String, int> gruposLimite = {
    'Grupo 1': 1,
    'Grupo 2': 2,
    'Grupo 3': 1,
    'Grupo 4': 2,
    'Grupo 5': 2,
    'Grupo 6': 2,
  };

  final Map<String, List<int>> gruposSelecionados = {
    'Grupo 1': [],
    'Grupo 2': [],
    'Grupo 3': [],
    'Grupo 4': [],
    'Grupo 5': [],
    'Grupo 6': [],
  };

  Map<String, bool> erroGrupo = {
    'Grupo 1': false,
    'Grupo 2': false,
    'Grupo 3': false,
    'Grupo 4': false,
    'Grupo 5': false,
    'Grupo 6': false,
  };

  bool temErroGrupos() => erroGrupo.values.any((erro) => erro == true);

  int totalTimesSelecionados() {
    int total = 0;
    gruposSelecionados.values.forEach((list) => total += list.length);
    return total;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;

    if (args != null && args is Participante && !isEdicao) {
      participanteEdicao = args;
      isEdicao = true;

      nomeController.text = participanteEdicao!.nome;

      participanteEdicao!.grupos.forEach((grupo, lista) {
        gruposSelecionados[grupo] = List<int>.from(lista);
      });
    }
  }

  Future<void> salvarParticipante() async {
    bool temErro = false;

    setState(() {
      erroNome = nomeController.text.trim().isEmpty;

      gruposLimite.forEach((grupo, limite) {
        if (gruposSelecionados[grupo]!.length != limite) {
          erroGrupo[grupo] = true;
          temErro = true;
        } else {
          erroGrupo[grupo] = false;
        }
      });
    });

    if (erroNome || temErro) {
      AppToast.error(
        context: context,
        text: 'Ainda existem campos para preencher',
      );
      return;
    }

    final participante = Participante(
      id: participanteEdicao?.id,
      nome: nomeController.text.trim(),
      grupos: gruposSelecionados,
    );

    if (isEdicao) {
      // Edição: apenas atualiza participante
      await DatabaseHelper.instance.atualizarParticipante(participante);
      
      AppToast.success(
        context: context,
        text: 'Participante atualizado com sucesso',
      );
      Navigator.pop(context);
      return;
    }

    // NOVO: Verificar se é admin ou usuário comum
    final usuarioLogado = SessionService.getUsuario();
    
    if (usuarioLogado == null) {
      AppToast.error(
        context: context,
        text: 'Erro: nenhum usuário logado. Faça login novamente.',
      );
      return;
    }
    
    // Se for usuário comum, verificar se já tem um participante
    if (!usuarioLogado.isAdmin) {
      // Verificar se o usuário já tem um participante vinculado
      final jaTemParticipante = usuarioLogado.participanteId != null;
      
      if (jaTemParticipante) {
        AppToast.error(
          context: context,
          text: 'Você já possui um participante cadastrado. Apenas um por usuário.',
        );
        return;
      }
    }
    
    // Insere participante e vincula ao usuário logado
    await DatabaseHelper.instance.inserirParticipanteParaUsuario(
      participante,
      usuarioLogado.id!,
    );
    
    // Atualizar a sessão com o novo participante_id
    final usuarioAtualizado = await DatabaseHelper.instance.buscarUsuarioPorId(usuarioLogado.id!);
    if (usuarioAtualizado != null) {
      SessionService.setUsuario(usuarioAtualizado);
    }
    
    AppToast.success(
      context: context,
      text: 'Participante cadastrado com sucesso!',
    );

    // Mostrar todos os participantes no console
    final participantes = await DatabaseHelper.instance.buscarParticipantes();
    print('----------------------------------');
    print('Lista de Participantes:');
    for (var p in participantes) {
      List<String> nomesTimes = [];
      p.grupos.forEach((grupo, idsTimes) {
        for (var id in idsTimes) {
          final time = timesData.firstWhere(
            (t) => t.id == id,
            orElse: () =>
                Time(id: 0, nome: 'Desconhecido', grupoId: 0, logo: '', abreviatura: ''),
          );
          nomesTimes.add(time.nome);
        }
      });
      print('ID: ${p.id}, Nome: ${p.nome}, Times escolhidos: $nomesTimes');
    }
    print('----------------------------------');

    // Limpar campos
    setState(() {
      nomeController.clear();
      gruposSelecionados.forEach((key, value) => value.clear());
      erroGrupo.forEach((key, value) => erroGrupo[key] = false);
      participanteEdicao = null;
      isEdicao = false;
    });

    // Voltar para lista
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: CustomAppBar(
        title: isEdicao ? 'Editar Participante' : 'Novo Participante',
        onThemeToggle: widget.onToggleTheme,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Nome do participante
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nomeController,
                  onChanged: (value) {
                    if (erroNome && value.trim().isNotEmpty) {
                      setState(() {
                        erroNome = false;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Nome do participante',
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: erroNome ? Colors.red : const Color(0XFFCDCDCD),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: erroNome ? Colors.red : const Color(0XFF0B5D3B),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Container de grupos: Times escolhidos
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: temErroGrupos() ? Colors.red : colorScheme.secondary,
                  width: 1.5,
                ),
              ),
              child: Text(
                'Grupos: Times escolhidos: ${totalTimesSelecionados()}/10',
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ),

            // Grupos expansíveis
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: gruposLimite.keys.map((grupo) {
                    final timesDoGrupo = timesData
                        .where((t) =>
                            t.grupoId == int.parse(grupo.split(' ')[1]))
                        .toList();

                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: erroGrupo[grupo]!
                              ? Colors.red
                              : colorScheme.secondary,
                          width: 1.5,
                        ),
                      ),
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          title: Text(
                            '$grupo - Escolher ${gruposLimite[grupo] == 1 ? "apenas 1" : gruposLimite[grupo]}',
                            style: textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          tilePadding:
                              const EdgeInsets.symmetric(horizontal: 8),
                          childrenPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          children: [
                            for (var time in timesDoGrupo) ...[
                              CustomCheckboxOption(
                                isSelected:
                                    gruposSelecionados[grupo]!.contains(time.id),
                                onChanged: (val) {
                                  final limiteAtingido =
                                      gruposSelecionados[grupo]!.length >=
                                          gruposLimite[grupo]!;

                                  if (limiteAtingido &&
                                      !gruposSelecionados[grupo]!
                                          .contains(time.id)) {
                                    final limite = gruposLimite[grupo];
                                    AppToast.error(
                                      context: context,
                                      text:
                                          '$grupo permite apenas $limite ${limite == 1 ? "time" : "times"}',
                                    );
                                    return;
                                  }

                                  setState(() {
                                    if (val == true) {
                                      gruposSelecionados[grupo]!.add(time.id!);
                                    } else {
                                      gruposSelecionados[grupo]!.remove(time.id!);
                                    }

                                    if (gruposSelecionados[grupo]!.length ==
                                        gruposLimite[grupo]) {
                                      erroGrupo[grupo] = false;
                                    }
                                  });
                                },
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      time.logo!,
                                      width: 24,
                                      height: 24,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      time.nome,
                                      style: textTheme.bodyMedium?.copyWith(
                                        color: colorScheme.onSurface,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Divider(
                                height: 1.5,
                                color:
                                    colorScheme.onSurface.withOpacity(0.05),
                              ),
                              const SizedBox(height: 8),
                            ],
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),

      // BottomBar fixo com botão Salvar
      bottomNavigationBar: BottomAppBar(
        color: colorScheme.surface,
        elevation: 4,
        child: SizedBox(
          height: 50,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: salvarParticipante,
              child: const Center(
                child: Text(
                  'Salvar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
