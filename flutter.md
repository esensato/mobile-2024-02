## React Native - Aula 01

- [NodeJs Download](https://nodejs.org/en/download)
- [React Native](https://reactnative.dev/)
- [VS Code](https://code.visualstudio.com/download)
- [Android Studio / SDK](https://developer.android.com/studio)

- Componentes visuais do React Native são compilados nativamente para as respectivas plataformas (iOS, Android, etc...)
- Lógica de negócio permanece em *JavaScript*

    ```c++
    void main() {
        print( '### Black Jack ###');
    }
    ```

***
### Variáveis
- Não precisa declarar explicitamente o tipo de dados desde que já seja atribuído um valor inicial
- Tipos de dados primitivos: `int`, `double`, `String` e `bool`
- Não é possíve utilizar uma variável antes que tenha um valor atribuído (*null safety*)!
    ```c
    void main() {
    
      int pontos_jogador;
      pontos_jogador = 0;
    
      var pontos_computador = 0;
      var nome_jogador = '';
    
      print('### Black Jack ###');
    
      print('Pontos computador $pontos_computador');
      print('Pontos computador $pontos_jogador');
    }
    ```
- Para obter dados de entrada, utilizar
    ```c
    import 'dart:io';
    String? nome_jogador = stdin.readLineSync();
    ```
***
### Constantes
- Criar constantes para representar os naipes do baralho
- - Definição de constantes
    ```c
    const COPAS = '\u2665';
    const ESPADAS = '\u2660';
    const OURO = '\u2666';
    const PAUS = '\u2663';
    ```
***
### Classes
- Criar uma classe para reprentar os jogadores do **Black Jack**
    ```c
    class Jogador {
      var nome = '';
      var aposta = 0;
      var pontos = 100;
    
      @override
      String toString() {
        return "$nome - pontos: $pontos";
      }
    }
    ```
- Instanciar e imprimir os valores padrão
    ```c
    var jogador = Jogador();
    print(jogador);
    ```
- Atribuir valores (não precisa de `get` e `set`)
    ```c
    var jogador = Jogador();
    jogador.nome = "Edson";
    print(jogador);
    ```
- Atributos e métodos `private` devem ser precedidos por "_"
    ```c
    class Jogador {
      var nome = '';
      var aposta = 0;
      var _pontos = 100;
    
      @override
      String toString() {
        return "$nome - pontos: $_pontos";
      }
    }
    ```
- Caso um atributo seja somente de leitura, criar o `get` correspondente
    ```c
    class Jogador {
      var nome = '';
      var aposta = 0;
      var _pontos = 100;
      get pontos => _pontos;
    
      @override
      String toString() {
        return "$nome - pontos: $pontos";
      }
    }
    ```
- Uma aposta deve ser limitada à quantidae de pontos que o jogador possui
    ```c
    var _aposta = 0;
    get aposta => _aposta;
    set aposta (nova_aposta) {
      if (nova_aposta < pontos) {
        this._aposta = nova_aposta;
      } else {
        print ('Valor invalido! Assumindo: $pontos');
        this._aposta = pontos;
      }
    }
    ```
- Criar um construtor para receber opcionalmente o nome do jogador - caso não informado, assume **Mesa**
    ```c
    class Jogador {
      var nome;
      var _pontos = 100;
      get pontos => _pontos;
    
      Jogador({this.nome = 'Mesa'});
    
    }
    ```
- Criar uma classe para representar uma carta
    ```c
    class Carta {
    
      var nome = '';
      var valor = 0;
    
      Carta (this.nome, this.valor);
    
      @override
      String toString() {
        return '$nome - $valor';
      }
    
    }
    ```
***
### Enums
- Criar um enumerado com as possíveis ações do jogador: *esperar*, *comprar* e *apostar*
```c
enum Acao {
  esperar, comprar, apostar, fim;
  static String opcoes() {
    return '${esperar.name}, ${comprar.name}, ${apostar.name}, ${fim.name}';
  }
}
```
***
### Funções Gerais
- Função para iniciar o jogo com as boas vindas
```c
void inicio() {
  print('### Black Jack ###');
  print('Informe o seu nome:');
  String? nome_jogador = stdin.readLineSync();
  jogador_pessoa = Jogador(nome: nome_jogador);
  print('Bem vindo: $jogador_pessoa');

}
```
- Registrar uma aposta para um jogador
```c
void aposta(Jogador jogador) {

  print('${jogador.nome} quantidade apostada:');
  String? aposta = stdin.readLineSync();
  while (aposta == '') {
    print('${jogador.nome} quantidade apostada:');
    aposta = stdin.readLineSync();
  }
 jogador.aposta = int.parse(aposta!);
}
```
- Definir uma variável do tipo lista que conterá todas as representações de cartas do baralho (incluir na classe `Jogador` também)
```c
var cartas = <Carta>[];
```
- Criar uma função para iniciar a lista de cartas
  ```c
  void criarCartas() {
    for (var i = 2; i < 11; i++) {
      cartas.add(Carta('$i$COPAS', i));
      cartas.add(Carta('$i$ESPADAS', i));
      cartas.add(Carta('$i$OURO', i));
      cartas.add(Carta('$i$PAUS', i));
    }
    cartas.add(Carta('J$COPAS', 10));
    cartas.add(Carta('J$ESPADAS', 10));
    cartas.add(Carta('J$OURO', 10));
    cartas.add(Carta('J$PAUS', 10));
  
    cartas.add(Carta('Q$COPAS', 10));
    cartas.add(Carta('Q$ESPADAS', 10));
    cartas.add(Carta('Q$OURO', 10));
    cartas.add(Carta('Q$PAUS', 10));
  
    cartas.add(Carta('K$COPAS', 10));
    cartas.add(Carta('K$ESPADAS', 10));
    cartas.add(Carta('K$OURO', 10));
    cartas.add(Carta('K$PAUS', 10));
  
    cartas.add(Carta('A$COPAS', 1));
    cartas.add(Carta('A$ESPADAS', 1));
    cartas.add(Carta('A$OURO', 1));
    cartas.add(Carta('A$PAUS', 1));
  
  }
  ```
- O sorteio de uma carta deve prever que ela seja sorteada apenas uma única vez
  ```c
  import 'dart:math'; // incluir o import no inicio do arquivo por conta do Random

  Carta sorteiaCarta() {
    int idCarta = Random().nextInt(cartas.length - 1);
    return cartas.removeAt(idCarta);
  }
  ```
- Escrever uma função para retornar o valor total das cartas na mão do jogador (utilizar o `forEach`)
```c
int valorCartas() {

  var total = 0;
  cartas.forEach((carta) {
    total += carta.valor;
  });

  return total;

}
```
- Definir uma função que retorna as opções para o usuário selecionar durante a sua jogada
```c
Acao opcoes() {
  print('O que você deseja? ${Acao.opcoes()}');
  var acao = stdin.readLineSync();
  switch (acao) {
    case "apostar":
      return Acao.apostar;
    case "comprar":
      return Acao.comprar;
    case "fim":
      return Acao.fim;
    default:
      return Acao.esperar;
  }
}
```

