import 'dart:io';

import 'package:simple_black_jack/carta.dart';
import 'package:simple_black_jack/jogador.dart';

const COPAS = '\u2665';
const ESPADAS = '\u2660';
const OURO = '\u2666';
const PAUS = '\u2663';

// Acoes que o jogador pode tomar
enum Acao {
  esperar, comprar, apostar, fim;
  static String opcoes() {
    return '${esperar.name}, ${comprar.name}, ${apostar.name}, ${fim.name}';
  }
}

var jogador_pessoa = Jogador();
var jogador_mesa = Jogador();

void inicio() {
  print('### Black Jack ###');
  print('Informe o seu nome:');
  // le o nome do jogador
  var nome_jogador = stdin.readLineSync();
  // somente ira criar o jogador se nome_jogador != null
  jogador_pessoa = Jogador(nome: nome_jogador!);
  print('Bem vindo: $jogador_pessoa');
}

void aposta(Jogador jogador) {
  print('${jogador.nome} quantidade apostada:');
  var aposta = stdin.readLineSync();
  while (aposta == '') {
    print('${jogador.nome} quantidade apostada:');
    aposta = stdin.readLineSync();
  }
  jogador.aposta = int.parse(aposta!);
}