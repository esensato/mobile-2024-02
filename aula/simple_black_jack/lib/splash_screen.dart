// splash screen
import 'package:flutter/material.dart';

class BlackJackSplash extends StatelessWidget {

  // passar uma função de callback que sera acionada apos 5 segundos
  // ? = valor pode ser null
  Function? onTimeout;

  BlackJackSplash({super.key, this.onTimeout}) {
    // programa a duração do splash (5 segundos)
    Future.delayed(const Duration(seconds: 5), (){
      // chamar o metodo de callback passado como parametro
      // ! = somente aciona a função caso o parâmetro onTimeout seja diferente de null
      onTimeout!();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('assets/blackjack-logo.png')),
    );
  }
}