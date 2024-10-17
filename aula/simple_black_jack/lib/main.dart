import 'package:flutter/material.dart';

void main() {
  // Criar a aplicação flutter
  runApp(BlackJackSplash());
}

// splash screen
class BlackJackSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        body: Center(child: Text("Simple Black Jack")),
      ),
    );

  }

}