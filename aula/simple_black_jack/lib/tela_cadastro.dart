import 'package:flutter/material.dart';
import 'package:simple_black_jack/tela_mesa_jogo.dart';

class TelaCadastro extends StatefulWidget {
  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {

  var txtNome = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Simple Black Jack')),
        body: Column(children: [
          const SizedBox(height: 10.0),
          Image.asset('assets/blackjack-logo.png', width: 128, height: 128,),
          Container(margin: const EdgeInsets.all(12), child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Informe o seu nome',
            ),
            controller: txtNome,
          ),)
          ,
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () {
              // Avança para a tela principal do jogo
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => TelaMesaJogo(jogador: txtNome.text,)),
              );
            },
            child: const Text('Iniciar o jogo'),
          ),
        ],)
,
      ),
    );
  }

}