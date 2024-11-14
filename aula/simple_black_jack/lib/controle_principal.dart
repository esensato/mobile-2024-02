import 'package:flutter/material.dart';
import 'package:simple_black_jack/db.dart';
import 'package:simple_black_jack/jogador_db.dart';
import 'package:simple_black_jack/splash_screen.dart';
import 'package:simple_black_jack/tela_cadastro.dart';
import 'package:simple_black_jack/tela_mesa_jogo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
    _telaAtual = BlackJackSplash(onTimeout: jogadorExiste);
  }

  // se o jogador ja existe no banco de dados vai para a tela da mesa do jogo
  // caso contrario vai para a tela de cadastro
  void jogadorExiste() {

    Db.abrir().then((db){

      // faz uma query no banco de dados pra ver se existe algum registro
      Db.obtemJogador(db).then((jogador){
        print(jogador);
        if (jogador.isEmpty) {
          exibirTelaCadastro();
        } else {
          // verificar se o jogador ja possui cadastro no backend
          getPontos(jogador: jogador.first['USERNAME']);
        }
      });

    });
  }

  int getPontos({var jogador = ''}) {
    // requisicao GET no endpoint https://simple-black-jack.glitch.me/
    final url = Uri.https('simple-black-jack.glitch.me', 'pontos/$jogador');
    print(url.toString());
    http.get(url, headers: <String, String> {'Content-Type' : 'application/json', 'Accept' : 'application/json'})
        .then((resposta) {
          if (resposta.statusCode == 200) { // 200 é bom!!! Usuario existe!
            Map<String, dynamic> mapa = jsonDecode(resposta.body);
                print(mapa['pontos']);
                setState(() {
                  _telaAtual = TelaMesaJogo(jogador: jogador, pontos: mapa['pontos']);
                });
          } else if (resposta.statusCode == 404){
            // se nao existe entao cadastra
            final url = Uri.https('simple-black-jack.glitch.me', 'novo');
            final Map<String, String> header = {'Content-Type' : 'application/json','Accept' : 'application/json'};
            final body = '{"username":"$jogador"}';
            // requisição http é assíncrona
            http.post(url, headers: header, body: body).then((resp) {
              print(resp);
              setState(() {
                // passa somente o nome do jogador cadastrado
                _telaAtual = TelaMesaJogo(jogador: jogador);
              });
            });
            return 1000;
          }
    });
    return -1;
  }

  // quando ocorrer o tempo do splash entao exibe a tela de cadastro
  void exibirTelaCadastro() {
    // atualizar a tela atual
    setState(() {
      _telaAtual = TelaCadastro(onStartGame: (nome) => setState(() {

        // faz a persistencia do jogador em base local
        Db.abrir().then((db){

          // faz uma query no banco de dados pra ver se existe algum registro
          Db.obtemJogador(db).then((jogador){
            print(jogador);
            if (jogador.isEmpty) {

              Db.inserir(db, JogadorDB(username: nome)).then((id) {
                print('Inserido jogador: $id');
                // verificar se o jogador ja possui cadastro no backend
                getPontos(jogador: nome);
              });
            } else {
              getPontos(jogador: nome);
            }
          });
        });
      }));
    });

  }

  @override
  Widget build(BuildContext context) {
    return _telaAtual!;
  }

}