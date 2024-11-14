import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:simple_black_jack/jogador.dart';
import 'package:simple_black_jack/styles.dart';
import 'package:simple_black_jack/util.dart';

class TelaMesaJogo extends StatefulWidget {

  Jogador? jogadorHumano;

  TelaMesaJogo({super.key, jogador = '', pontos = 1000}) {
    jogadorHumano = Jogador(nome: jogador, pontos: pontos);
  }

  @override
  State<TelaMesaJogo> createState() => _TelaMesaJogoState();
}

class _TelaMesaJogoState extends State<TelaMesaJogo> {

  // contém a imagem do verso das cartas
  Uint8List? _versoCarta;
  // imagem de todas as cartas
  Uint8List? _imagemCarta;
  // array que representa as cartas do jogador
  var _cartasJogador = [];
  // indica se a imagem das cartas ja foi carregada (assincrono)
  var _esperar = true;

  var cartaAtualJogadorIdx = 0;

  // executado somente uma vez na inicialização do State
  @override
  void initState() {
    super.initState();
    loadImagem(nome: 'verso-carta.png').then((img){
      _versoCarta = img;
      // carrega as cartas com a imagem do verso
      _cartasJogador = [_versoCarta, _versoCarta, _versoCarta, _versoCarta];
    });

    loadImagem(nome: 'card-deck.png').then((img){
      _imagemCarta = img;
      setState(() {
        // imagens ja carregadas, pode exibir as cartas
        _esperar = false;
      });
    });
  }

  Widget getPlacar() {
    return Container(margin: const EdgeInsets.all(10.0),
       padding: const EdgeInsets.all(5.0),
       decoration: Styles.getBoxDecoration(),
        child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Jogador: ${widget.jogadorHumano?.nome}', style: Styles.getTextStyle(),),
          Text('Pontos: ${widget.jogadorHumano?.pontos}', style: Styles.getTextStyle())
        ]));
  }

  Widget getCartasMesa() {
    return Row(children: [Expanded(child: Image.memory(_versoCarta!)),
      Expanded(child: Image.memory(_versoCarta!)),
      Expanded(child: Image.memory(_versoCarta!)),
      Expanded(child: Image.memory(_versoCarta!))
    ]);
  }

  Widget getCartasJogador() {
    return Row(children: [Expanded(child: Image.memory(_cartasJogador[0])),
      Expanded(child: Image.memory(_cartasJogador[1])),
      Expanded(child: Image.memory(_cartasJogador[2])),
      Expanded(child: Image.memory(_cartasJogador[3]))
    ]);
  }

  Widget getBotoes() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [ElevatedButton(style: Styles.getButtonStyle(), onPressed: (){}, child: const Text('Apostar')),
      ElevatedButton(style: Styles.getButtonStyle(), onPressed: comprar, child: const Text('Comprar')),
      ElevatedButton(style: Styles.getButtonStyle(), onPressed: (){}, child: const Text('Passar')),
      ElevatedButton(style: Styles.getButtonStyle(), onPressed: fim, child: const Text('Fim'))]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Simple Black Jack')),
        // enquanto não carregar as imagens exibe um indicador de progresso...
        body: _esperar ? const CircularProgressIndicator() : Column(children: [getPlacar(),
        getCartasMesa(),
          getCartasJogador(),
          getBotoes()
        ]),
      ),
    );
  }

  void comprar() {
    if (cartaAtualJogadorIdx < _cartasJogador.length) {

      setState(() {
        final int idCarta = Random().nextInt(totalCartaColuna * totalCartaLinha);
        _cartasJogador[cartaAtualJogadorIdx] = getCarta(idCarta, _imagemCarta!);
      });
      cartaAtualJogadorIdx++;

    }
  }

  void fim() {
    cartaAtualJogadorIdx = 0;
    setState(() {
      _cartasJogador = [_versoCarta, _versoCarta, _versoCarta, _versoCarta];
    });

  }

}