import 'package:flutter/material.dart';
import 'package:simple_black_jack/jogador.dart';

class TelaMesaJogo extends StatefulWidget {

  var jogador_humano;

  TelaMesaJogo({jogador = ''}) {
    jogador_humano = Jogador(nome: jogador);
  }

  @override
  State<TelaMesaJogo> createState() => _TelaMesaJogoState();
}

class _TelaMesaJogoState extends State<TelaMesaJogo> {

  Widget getPlacar() {
    return Row(children: [
      Expanded(flex: 2, child: Text('Jogador: ${widget.jogador_humano.nome}')),
      Expanded(flex: 1,child: Text('Pontos: ${widget.jogador_humano.pontos}'))
    ]);
  }

  Widget getCartas() {
    return Row(children: [Expanded(child: Image.asset("assets/verso-carta.png")),
      Expanded(child: Image.asset("assets/verso-carta.png")),
      Expanded(child: Image.asset("assets/verso-carta.png")),
      Expanded(child: Image.asset("assets/verso-carta.png"))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Simple Black Jack')),
        body: Column(children: [getPlacar(),
        getCartas(),
          getCartas()
        ]),
        floatingActionButton: FloatingActionButton(onPressed: () {
          setState(() {
            widget.jogador_humano.pontos++;
          });
        }),
      ),
    );
  }

}