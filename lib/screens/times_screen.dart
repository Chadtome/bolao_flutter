// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../database/database_helper.dart';
// //import '../models/time.dart';

// class TimesScreen extends StatelessWidget {
//   const TimesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Times cadastrados')),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: DatabaseHelper.instance.database.then((db) => db.query('times')),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text('Erro ao carregar times: ${snapshot.error}'));
//           }
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('Nenhum time cadastrado'));
//           }

//           final times = snapshot.data!;
//           return ListView.builder(
//             itemCount: times.length,
//             itemBuilder: (context, index) {
//               final time = times[index];
//               return ListTile(
//                 leading: SvgPicture.asset(
//                   time['logo'],
//                   width: 30,
//                   height: 30,
//                   placeholderBuilder: (context) => const Icon(Icons.image_not_supported),
//                   fit: BoxFit.contain,
//                       //const CircularProgressIndicator(),
//                 ),
//                 title: Text(time['nome']),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }