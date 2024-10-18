import 'package:flutter/material.dart';
import 'package:simple_black_jack/tela_cadastro.dart';

void main() {
  // Criar a aplicação flutter
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: _BlackJackSplash());
  }
}

// splash screen
class _BlackJackSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // programa a duração do splash
    Future.delayed(const Duration(seconds: 5), (){
     // chamar a tela principal do app
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => TelaCadastro()),
      );

    });

    return Scaffold(
        body: Center(child: Image.asset('assets/blackjack-logo.png')),
    );
  }
}