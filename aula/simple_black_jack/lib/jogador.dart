class Jogador {
  var nome = '';
  var _aposta = 0; // private
  get aposta => _aposta;
  set aposta (valor) {
    // se valor da aposta menor que os pontos, ok!
    if (valor <= pontos) {
      _aposta = valor;
    } else {
      _aposta = pontos;
    }
  }
  var pontos = 1000;

  // metodo construtor com parametro nomeado e opcional.
  // Ex: var j = Jogador(nome: 'Teste') ou var j = Jogador()
  Jogador({this.nome = 'Mesa', this.pontos = 1000});

  @override
  String toString() {
    return "$nome - pontos: $pontos - aposta: $aposta";
  }
}