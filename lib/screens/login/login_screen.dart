// import 'package:bolao_/database/database_helper.dart';
// import 'package:bolao_/models/usuario.dart';
// import 'package:bolao_/services/session_service.dart';
// import 'package:bolao_/widgets/toast.widget.dart';
// import 'package:flutter/material.dart';

// class LoginScreen extends StatefulWidget {
//   final VoidCallback onToggleTheme;
//   const LoginScreen({super.key, required this.onToggleTheme});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _loginController = TextEditingController();
//   final TextEditingController _senhaController = TextEditingController();
//   bool _obscureText = true;
//   bool _carregando = false;

//   Future<void> _fazerLogin() async {
//     final login = _loginController.text.trim();
//     final senha = _senhaController.text.trim();

//     if (login.isEmpty || senha.isEmpty) {
//       AppToast.error(context: context, text: 'Preencha login e senha');
//       return;
//     }

//     setState(() {
//       _carregando = true;
//     });

//     try {
//       final usuarioMap = await DatabaseHelper.instance.buscarUsuario(login, senha);
      
//       if (usuarioMap != null) {
//         final usuario = Usuario.fromMap(usuarioMap);
//         SessionService.setUsuario(usuario);
        
//         if (mounted) {
//           // Navegar para a Home (vamos criar depois)
//           Navigator.pushReplacementNamed(
//             context,
//             '/menu',
//             arguments: usuario,
//           );
//         }
//       } else {
//         AppToast.error(context: context, text: 'Login ou senha incorretos');
//       }
//     } catch (e) {
//       AppToast.error(context: context, text: 'Erro ao fazer login');
//     } finally {
//       if (mounted) {
//         setState(() {
//           _carregando = false;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
    
//     return Scaffold(
//       backgroundColor: colorScheme.background,
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Logo/Ícone
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF0B5D3B).withOpacity(0.1),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.sports_soccer,
//                 size: 60,
//                 color: Color(0xFF0B5D3B),
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Bolão 2026',
//               style: TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF0B5D3B),
//               ),
//             ),
//             const SizedBox(height: 48),
            
//             // Campo Login
//             TextField(
//               controller: _loginController,
//               decoration: InputDecoration(
//                 labelText: 'Usuário',
//                 prefixIcon: const Icon(Icons.person),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide(color: Colors.grey.shade300),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(color: Color(0xFF0B5D3B), width: 2),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
            
//             // Campo Senha
//             TextField(
//               controller: _senhaController,
//               obscureText: _obscureText,
//               decoration: InputDecoration(
//                 labelText: 'Senha',
//                 prefixIcon: const Icon(Icons.lock),
//                 suffixIcon: IconButton(
//                   icon: Icon(
//                     _obscureText ? Icons.visibility_off : Icons.visibility,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       _obscureText = !_obscureText;
//                     });
//                   },
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide(color: Colors.grey.shade300),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(color: Color(0xFF0B5D3B), width: 2),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 32),
            
//             // Botão Entrar
//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: _carregando ? null : _fazerLogin,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF0B5D3B),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: _carregando
//                     ? const SizedBox(
//                         width: 20,
//                         height: 20,
//                         child: CircularProgressIndicator(
//                           strokeWidth: 2,
//                           color: Colors.white,
//                         ),
//                       )
//                     : const Text(
//                         'ENTRAR',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:bolao_/database/database_helper.dart';
import 'package:bolao_/models/usuario.dart';
import 'package:bolao_/services/session_service.dart';
import 'package:bolao_/widgets/toast.widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  const LoginScreen({super.key, required this.onToggleTheme});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  bool _obscureText = true;
  bool _carregando = false;

  Future<void> _fazerLogin() async {
    final login = _loginController.text.trim();
    final senha = _senhaController.text.trim();

    if (login.isEmpty || senha.isEmpty) {
      AppToast.error(context: context, text: 'Preencha login e senha');
      return;
    }

    setState(() {
      _carregando = true;
    });

    try {
      final usuarioMap = await DatabaseHelper.instance.buscarUsuario(login, senha);
      
      if (usuarioMap != null) {
        final usuario = Usuario.fromMap(usuarioMap);
        SessionService.setUsuario(usuario);
        
        if (mounted) {
          Navigator.pushReplacementNamed(
            context,
            '/menu',
            arguments: usuario,
          );
        }
      } else {
        AppToast.error(context: context, text: 'Login ou senha incorretos');
      }
    } catch (e) {
      AppToast.error(context: context, text: 'Erro ao fazer login');
    } finally {
      if (mounted) {
        setState(() {
          _carregando = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo/Ícone
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF0B5D3B).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.sports_soccer,
                size: 60,
                color: Color(0xFF0B5D3B),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Bolão 2026',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0B5D3B),
              ),
            ),
            const SizedBox(height: 48),
            
            // Campo Login
            TextField(
              controller: _loginController,
              decoration: InputDecoration(
                labelText: 'Usuário',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF0B5D3B), width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Campo Senha
            TextField(
              controller: _senhaController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                labelText: 'Senha',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF0B5D3B), width: 2),
                ),
              ),
            ),
            const SizedBox(height: 32),
            
            // Botão Entrar
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _carregando ? null : _fazerLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0B5D3B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _carregando
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'ENTRAR',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
            
            // 👉 NOVO: Botão Criar Conta
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Não tem uma conta?'),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/criar_conta');
                  },
                  child: const Text(
                    'Criar conta',
                    style: TextStyle(color: Color(0xFF0B5D3B)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}