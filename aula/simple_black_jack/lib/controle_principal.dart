import 'package:flutter/material.dart';
import 'package:simple_black_jack/splash_screen.dart';
import 'package:simple_black_jack/tela_cadastro.dart';
import 'package:simple_black_jack/tela_mesa_jogo.dart';

// Esta classe controla qual a tela a ser exibida (navegação)
class ControlePrincipal extends StatefulWidget {

  const ControlePrincipal({super.key});

  @override
  State<StatefulWidget> createState() => _ControlePrincipalState();

}

class _ControlePrincipalState extends State<ControlePrincipal> {

  // indica qual é a tela a ser exibida
  // _ = private
  Widget? _telaAtual;

  _ControlePrincipalState() {
    _telaAtual = BlackJackSplash(onTimeout: exibirTelaCadastro);
  }

  // quando ocorrer o tempo do splash entao exibe a tela de cadastro
  void exibirTelaCadastro() {
    // atualizar a tela atual
    setState(() {
      _telaAtual = TelaCadastro(onStartGame: (nome) => setState(() {
        _telaAtual = TelaMesaJogo(jogador: nome);
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return _telaAtual!;
  }

}