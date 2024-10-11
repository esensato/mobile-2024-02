class Carta {

  var nome = '';
  var valor = 0;

  Carta (this.nome, this.valor);

  @override
  String toString() {
    return '$nome - $valor';
  }

}