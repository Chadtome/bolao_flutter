// import 'package:flutter/material.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final bool showBackButton;
//   final VoidCallback? onThemeToggle;

//   const CustomAppBar({
//     Key? key,
//     required this.title,
//     this.showBackButton = true,
//     this.onThemeToggle,
//   }) : super(key: key);

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       // Cor de fundo fixa
//       backgroundColor: const Color(0xFF0B5D3B),
//       // Seta de voltar
//       leading: showBackButton ? const BackButton(color: Colors.white) : null,
//       title: Text(
//         title,
//         style: const TextStyle(
//           color: Colors.white,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       centerTitle: true,
//       elevation: 0,
//       actions: [
//         IconButton(
//           icon: const Icon(Icons.brightness_6, color: Colors.white),
//           onPressed: onThemeToggle,
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onThemeToggle;
  final List<Widget>? actions; // 👈 NOVO: ações opcionais

  const CustomAppBar({
    Key? key,
    required this.title,
    this.showBackButton = true,
    this.onThemeToggle,
    this.actions, // 👈 NOVO
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF0B5D3B),
      leading: showBackButton ? const BackButton(color: Colors.white) : null,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      actions: [
        // Botão de tema SEMPRE presente
        IconButton(
          icon: const Icon(Icons.brightness_6, color: Colors.white),
          onPressed: onThemeToggle,
        ),
        if (actions != null) ...actions!,
      ],
    );
  }
}