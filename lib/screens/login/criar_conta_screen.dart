import 'package:bolao_/database/database_helper.dart';
import 'package:bolao_/widgets/toast.widget.dart';
import 'package:flutter/material.dart';

class TelaCriarConta extends StatefulWidget {
  final VoidCallback onToggleTheme;
  const TelaCriarConta({super.key, required this.onToggleTheme});

  @override
  State<TelaCriarConta> createState() => _TelaCriarContaState();
}

class _TelaCriarContaState extends State<TelaCriarConta> {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmarSenhaController = TextEditingController();
  
  bool _obscureText = true;
  bool _obscureConfirmText = true;
  bool _carregando = false;
  
  bool erroLogin = false;
  bool erroSenha = false;
  bool erroConfirmarSenha = false;
  String? erroLoginMensagem;

  Future<bool> _validarLogin() async {
    final login = loginController.text.trim();
    
    if (login.isEmpty) {
      erroLogin = true;
      erroLoginMensagem = 'Digite um login';
      return false;
    }
    
    if (login.contains(' ')) {
      erroLogin = true;
      erroLoginMensagem = 'Login não pode conter espaços';
      return false;
    }
    
    final db = await DatabaseHelper.instance.database;
    final result = await db.query(
      'usuarios',
      where: 'login = ?',
      whereArgs: [login],
    );
    
    if (result.isNotEmpty) {
      erroLogin = true;
      erroLoginMensagem = 'Este login já está em uso';
      return false;
    }
    
    erroLogin = false;
    erroLoginMensagem = null;
    return true;
  }
  
  bool _validarSenha() {
    final senha = senhaController.text;
    
    if (senha.isEmpty) {
      erroSenha = true;
      return false;
    }
    
    if (senha.length < 4) {
      erroSenha = true;
      return false;
    }
    
    erroSenha = false;
    return true;
  }
  
  bool _validarConfirmarSenha() {
    final senha = senhaController.text;
    final confirmar = confirmarSenhaController.text;
    
    if (confirmar.isEmpty) {
      erroConfirmarSenha = true;
      return false;
    }
    
    if (senha != confirmar) {
      erroConfirmarSenha = true;
      return false;
    }
    
    erroConfirmarSenha = false;
    return true;
  }

  Future<void> _criarConta() async {
    final loginValido = await _validarLogin();
    final senhaValido = _validarSenha();
    final confirmarValido = _validarConfirmarSenha();
    
    setState(() {
      erroLogin = !loginValido;
      erroSenha = !senhaValido;
      erroConfirmarSenha = !confirmarValido;
    });
    
    if (!loginValido || !senhaValido || !confirmarValido) {
      AppToast.error(
        context: context,
        text: 'Preencha todos os campos corretamente',
      );
      return;
    }
    
    setState(() {
      _carregando = true;
    });
    
    try {
      final login = loginController.text.trim();
      final senha = senhaController.text;
      
      await DatabaseHelper.instance.criarUsuario(login, senha);
      
      AppToast.success(
        context: context,
        text: 'Conta criada com sucesso! Faça login para continuar.',
      );
      
      Navigator.pushReplacementNamed(context, '/login');
      
    } catch (e) {
      AppToast.error(context: context, text: 'Erro ao criar conta: $e');
    } finally {
      setState(() {
        _carregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: const Text('Criar Conta'),
        backgroundColor: const Color(0xFF0B5D3B),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(  // 👈 ADICIONADO
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF0B5D3B).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_add,
                size: 60,
                color: Color(0xFF0B5D3B),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Criar Conta',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0B5D3B),
              ),
            ),
            const SizedBox(height: 48),
            
            TextField(
              controller: loginController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                labelText: 'Login',
                prefixIcon: const Icon(Icons.person),
                errorText: erroLoginMensagem,
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
            
            TextField(
              controller: senhaController,
              obscureText: _obscureText,
              onChanged: (_) => setState(() {
                _validarSenha();
                _validarConfirmarSenha();
              }),
              decoration: InputDecoration(
                labelText: 'Senha (mínimo 4 caracteres)',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _obscureText = !_obscureText),
                ),
                errorText: erroSenha ? 'Senha deve ter pelo menos 4 caracteres' : null,
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
            
            TextField(
              controller: confirmarSenhaController,
              obscureText: _obscureConfirmText,
              onChanged: (_) => setState(() => _validarConfirmarSenha()),
              decoration: InputDecoration(
                labelText: 'Confirmar Senha',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(_obscureConfirmText ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _obscureConfirmText = !_obscureConfirmText),
                ),
                errorText: erroConfirmarSenha ? 'As senhas não coincidem' : null,
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
            
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _carregando ? null : _criarConta,
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
                        'CRIAR CONTA',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
            
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Já tem uma conta?'),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text(
                    'Fazer login',
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