import 'package:flutter/material.dart';
import 'package:simple_black_jack/styles.dart';
import 'package:simple_black_jack/tela_mesa_jogo.dart';

class TelaCadastro extends StatefulWidget {

  // função callback acionada quando o usuario clicar no botão Iniciar Jogo
  Function? onStartGame;

  TelaCadastro({super.key, this.onStartGame});

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
            decoration: Styles.getInputTextStyle(label: 'Informe seu nome'),
            controller: txtNome,
          ),)
          ,
          const SizedBox(height: 10.0),
          ElevatedButton(
            style: Styles.getButtonStyle(cor: Colors.green[700]),
            onPressed: () {
              // acionar o método de callback onStartGame passado como parâmetro
              // devolver para onStartGame o nome do jogador informado no campo txtNome
              widget.onStartGame!(txtNome.text);
            },
            child: Text('Iniciar o jogo', style: Styles.getTextStyle()),
          ),
        ],)
,
      ),
    );
  }

}