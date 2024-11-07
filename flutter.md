## Flutter / Dart

- [Flutter Download Mac Silicon](https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_arm64_3.24.3-stable.zip)
- [Flutter Download Mac Intel](https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_3.24.3-stable.zip)
- [Flutter Download Windows](https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.24.3-stable.zip)
### Linguagem Dart
- Primeiro programa em **Dart**

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
***
### Flutter
- Criar uma pasta `assets` dentro da raiz do projeto
- Copiar o arquivo `card-deck.png` para dentro da pasta `assets`
- Incluir a referência dentro do arquivo `pubspec.yaml`
```yml
flutter:
  assets:
    - assets/
```
- As imagens podem ser obtidas aqui: [blackjack-logo.png](https://github.com/esensato/mobile-2024-02/blob/main/img/blackjack-logo.png) e [card-deck.png](https://github.com/esensato/mobile-2024-02/blob/main/img/card-deck.png) e [verso-carta.png](https://github.com/esensato/mobile-2024-02/blob/main/img/verso-carta.png)
- Incluir também as dependências
```yml
dependencies:
  image: ^4.2.0
  flutter:
    sdk: flutter
```
- Uma referência dos principais *widgets* do **flutter** podem ser vistos aqui [api.flutter.dev - material](https://api.flutter.dev/flutter/material/material-library.html)
- Dentro do arquivo `main.dart` definir a primeira tela do jogo
```dart
import 'package:flutter/material.dart';
void main() async {

  runApp(const BlackJackApp());

}

class BlackJackApp extends StatelessWidget {

  const BlackJackApp({super.key});

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      title: 'Simple Black Jack',
      home: Center(child: Text('Simple Black Jack'))
    );
  }
}
```
- Implementar a tela principal do jogo em um arquivo `tela_principal.dart` que servirá apenas para controlar a exibição das demais telas a serem criadas
```dart
import 'package:flutter/material.dart';

class TelaPrincipal extends StatefulWidget {

  const TelaPrincipal({super.key});

  @override
  State<StatefulWidget> createState() => _TelaPrincipalState();

}

class _TelaPrincipalState extends State<TelaPrincipal> {
  
  @override
  Widget build(BuildContext context) {
      return const Scaffold(body: Center(child: Text('Simple Black Jack')));
  }

}
```
- Alterar a `main.dart` para que a propriedade `home` aponte para a `TelaPrincipal`
```dart
import 'package:flutter/material.dart';
import 'package:simple_black_jack_local/tela_principal.dart';

void main() async {

  runApp(const BlackJackApp());

}

class BlackJackApp extends StatelessWidget {

  const BlackJackApp({super.key});

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      title: 'Simple Black Jack',
      home: TelaPrincipal()
    );

  }

}
```
- Criar uma *splash screen* para iniciar o jogo em um arquivo `splash_screen.dart`
```dart
import 'package:flutter/material.dart';

class BlackJackSplash extends StatelessWidget {

  const BlackJackSplash({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/blackjack-logo.png")
            ],
          ),
        )
    );
  }

}
```
- Cria inicialmente a tela de cadastro do jogador em um arquivo `tela_cadastro.dart`
```dart
import 'package:flutter/material.dart';

class TelaCadastro extends StatefulWidget {

   const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();

}

class _TelaCadastroState extends State<TelaCadastro> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Simple Black Jack')),
        body: const Center(child: Text('Tela de Cadastro'))
      ),
    );

  }

}
```
- Criar inicialmente a tela da mesa do jogo em um arquivo `tela_mesa_jogo.dart`
```dart
import 'package:flutter/material.dart';

class TelaMesaJogo extends StatefulWidget {

  final nome;

  const TelaMesaJogo({super.key, this.nome});

  @override
  State<TelaMesaJogo> createState() => _TelaMesaJogoState();
}

class _TelaMesaJogoState extends State<TelaMesaJogo> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Simple Black Jack')),
        body: const Center(child: Text('Mesa do Jogo'))
      ),
    );
  }

}
```
- Atualizar a `tela_principal.dart` com o código para fechamento automático da tela e direcionamento para a tela de cadastro
```dart
import 'package:flutter/material.dart';
import 'package:simple_black_jack_local/splash_screen.dart';
import 'package:simple_black_jack_local/tela_cadastro.dart';

class TelaPrincipal extends StatefulWidget {

  const TelaPrincipal({super.key});

  @override
  State<StatefulWidget> createState() => _TelaPrincipalState();

}

class _TelaPrincipalState extends State<TelaPrincipal> {

  Widget telaAtual = const BlackJackSplash();

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        telaAtual = TelaCadastro();
      });
    });

      return telaAtual;
  }

}
```
- Editar a tela de cadastro `tela_cadastro.dart` para que o jogador informe o seu nome utilizando um [TextField](https://api.flutter.dev/flutter/material/TextField-class.html) e um [ElevatedButton](https://api.flutter.dev/flutter/material/ElevatedButton-class.html)
- Para incluir espaços em branco entre os *widgets* pode-se utilizar o [SizedBox](https://api.flutter.dev/flutter/widgets/SizedBox-class.html)
```dart
import 'package:flutter/material.dart';

class TelaCadastro extends StatefulWidget {

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();

}

class _TelaCadastroState extends State<TelaCadastro> {

  var txtNome = TextEditingController();

  Widget getTxtNome() {
    return Container(margin: const EdgeInsets.all(12),
        child:  TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Informe o seu nome',
      ),
      controller: txtNome,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Simple Black Jack')),
        body: Column(children: [
          Image.asset("assets/blackjack-logo.png", width: 128, height: 128),
          const SizedBox(height: 10.0),
          getTxtNome(),
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Iniciar o jogo'),
          ),
        ],)
        ,
      ),
    );
  }

}
```
- Quando o *widget* `TelaCadastro` for instanciado ele deve receber um método de *callback* como parâmetro para que seja acionado quando o usuário clicar no botão **Iniciar Jogo**
```dart
class TelaCadastro extends StatefulWidget {

  Function? iniciarJogoOnClick;

   TelaCadastro({super.key,  this.iniciarJogoOnClick});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}
```
- Alterar também a função `build` para incluir no `onPressed` a chamada para o *callback* passando o nome do jogador como parâmetro
```dart
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Simple Black Jack')),
        body: Column(children: [
          Image.asset("assets/blackjack-logo.png", width: 128, height: 128),
          const SizedBox(height: 10.0),
          getTxtNome(),
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () {

              widget.iniciarJogoOnClick!(txtNome.text);

            },
            child: const Text('Iniciar o jogo'),
          ),
        ],)
        ,
      ),
    );
  }
```
- A mesma coisa deve ocorrer com a `BlackJackSplash`
```dart
import 'package:flutter/material.dart';

class BlackJackSplash extends StatelessWidget {

  final Function? onTimeout;

  const BlackJackSplash({super.key, this.onTimeout});

  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(seconds: 5), () {
      onTimeout!();
    });

    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/blackjack-logo.png")
            ],
          ),
        )
    );
  }
}
```
- Refatorar a `TelaPrincipal` para acionar as demais passando os métodos de *callback*
```dart
import 'package:flutter/material.dart';
import 'package:simple_black_jack_local/splash_screen.dart';
import 'package:simple_black_jack_local/tela_cadastro.dart';
import 'package:simple_black_jack_local/tela_mesa_jogo.dart';

class TelaPrincipal extends StatefulWidget {

  const TelaPrincipal({super.key});

  @override
  State<StatefulWidget> createState() => _TelaPrincipalState();

}

class _TelaPrincipalState extends State<TelaPrincipal> {

  Widget? telaAtual;

  _TelaPrincipalState() {

    telaAtual = BlackJackSplash(onTimeout: () => exibirTelaCadastro());

  }

  void exibirTelaCadastro() {

    setState(() {
      telaAtual = TelaCadastro(iniciarJogoOnClick: (nome){
        exibirTelaMesa(nome: nome);
      });
    });

  }

  void exibirTelaMesa({String nome = ''}) {

    setState(() {
      telaAtual = TelaMesaJogo();
    });

  }

  @override
  Widget build(BuildContext context) {

      return telaAtual!;

  }

}
```
- Editar a tela `tela_mesa_jogo.dart` que exibe a mesa do jogo
```dart
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
```
- Para facilitar a manutenção, criar uma classe para armazenar as *decorations* e aplicar, por exemplo, no `Container` que contém as cartas da mesa
```dart
import 'package:flutter/material.dart';

class Decorations {

  static Decoration getBoxDecoration() {

    return BoxDecoration(
      color: Colors.green,
      border: Border.all(
        color: Colors.black,
        width: 2.0,
      ),
    );

  }

  static ButtonStyle getButtonStyle() {

    return ElevatedButton.styleFrom(
    backgroundColor: Colors.green[700],
    shadowColor: Colors.green,
    elevation: 3,
    );

  }

  static TextStyle getButtonTextStyle() {

    return const TextStyle(color: Colors.white);

  }

}
```
- Por exemplo, para as cartas
```dart
Widget getCartas() {
  return Container(decoration: Decorations.getBoxDecoration(),
  child:Row(children: [Expanded(child: Image.asset("assets/verso-carta.png")),
    Expanded(child: Image.asset("assets/verso-carta.png")),
    Expanded(child: Image.asset("assets/verso-carta.png")),
    Expanded(child: Image.asset("assets/verso-carta.png"))
  ]));

}
```
- Código de inicialização para carregar a imagem das cartas dentro de `_TelaMesaJogoState`
```dart

  // variaveis
  var imagemCarta;
  var versoCarta;
  var _esperar = true;
  var cartas;

  // método acionado na inicialização (somente uma vez)
  @override
  void initState() {
    super.initState();

    loadImagem(nome: 'verso-carta.png').then((img){
      versoCarta = img;
      // carrega as cartas com a imagem do verso
      cartas = [versoCarta, versoCarta, versoCarta, versoCarta];

    });

    loadImagem(nome: 'card-deck.png').then((img){
      imagemCarta = img;
      setState(() {
        _esperar = false;
        cartas[0] = getCarta(0, imagemCarta);
      });
    });
  }
```
- Incluir um [CircularProgressIndicator](https://api.flutter.dev/flutter/material/CircularProgressIndicator-class.html) para exibir a tela somente quando a imagem das cartas for carregada
- Criar uma caixa de texto para que o jogador possa realizar a aposta
```dart
  Widget getAposta() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: (){
            // implementar: diminuir aposta
            },
          ),
          SizedBox(
            width: 80,
            child: TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
            // implementar: aumentar aposta
            },
          )
        ]);
  }
```
#### Trabalhando com JSON
- Utilizar o pacote convert (`dart:convert`) para interpretar a sintaxe JSON com a função `json.decode`
- Objeto simples
```dart
import 'dart:convert';

var jsonMap = '{"id":"123"}'; //Objeto JSON simples
Map<String, dynamic> mapa = json.decode(jsonMap);
print(json.decode(mapa['id']));
```
- Objeto do tipo `array`
```dart
var jsonList = '[{"id":"123"}, {"id":"456"}]'; //Objeto JSON Array
List<dynamic> lista = json.decode(jsonList);
lista.forEach((element) {
  print(element['id']);
});
```
- Objeto complexo
```dart
// Array com Array
var jsonComplexo = '[{"id":"123", "itens":["A","B"]}, '{"id":"456", "itens":["C","D"]}]';
List<dynamic> listaComplexo = json.decode(jsonComplexo);
listaComplexo.forEach((element) {
  print(element['itens'][0]);
});
```
#### Requisições HTTP
- O pacote http (`package:http/http.dart`) oferece uma grande facilidade na execução de requisições *HTTP* (*GET*, *POST*, etc...)
- Tais requisições podem ser utilizadas para interagir com serviços publicados na Internet (nuvem) utilizando o padrão *RESTFul*
- A classe [Uri](https://api.flutter.dev/flutter/dart-core/Uri-class.html) possui uma série de funções interessantes para criar *URLs* padronizadas e faz parte do pacote *core* do **Flutter**
- Exemplo de uma requisição *GET*
```dart
import 'package:http/http.dart' as http;

final url = Uri.https('simple-black-jack.glitch.me', 'pontos');
http.get(uri,
    headers: <String, String> {'Content-Type' : 'application/json', 'Accept' : 'application/json'})
    .then((resposta) => {
      if (resposta.statusCode == 200) {
        print(jsonDecode(resposta.body));
      }
});
```
- Exemplo de uma requisição *POST*
```dart
final url = Uri.https('simple-black-jack.glitch.me', 'novo');
final Map<String, String> header = {'Content-Type' : 'application/json',
                                    'Accept' : 'application/json'};
final body = '{"username":"${username.text}"}';
// requisição http é assíncrona
http.post(url, headers: header, body: body).then((resp) {

    print(resp);

});
```
- Funções úteis para manipulação de imagens
```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

const larguraImagem = 99;
const alturaImagem = 153;
const totalCartaLinha = 4;
const totalCartaColuna = 13;

Future<Uint8List> loadImagem({String nome = ''}) async {

  WidgetsFlutterBinding.ensureInitialized();
  final ByteData data = await rootBundle.load("assets/$nome");
  return data.buffer.asUint8List();

}

Uint8List getCarta(int nro, Uint8List imagem) {

  var originalImage = img.decodeImage(imagem);
  var copyedImage = img.copyCrop(originalImage!, getImgX(nro), getImgY(nro), larguraImagem, alturaImagem);
  return Uint8List.fromList(img.encodePng(copyedImage));

}

int getImgX(int pos) {

  final int x = pos - ((pos ~/ totalCartaColuna) * totalCartaColuna);
  print('x = $x, ${x * larguraImagem}');
  return x * larguraImagem - (x * 0.5).toInt();

}

int getImgY(int pos) {

  final int y = (pos ~/ totalCartaColuna);
  print('y = $y, ${y * alturaImagem}');
  return y * alturaImagem;

}
```
***
### Persistência com SQLite
- Adicionar as dependências no `pubspec.yaml`
```yml
sqflite:
path:
```
- Criar uma classe para representar os dados que serão persistidos
```dart
class JogadorDB {

    String username;
    
    JogadorDB({this.username = ''});
    
    Map<String, dynamic> toMap() {
    
      return {'username': username};
    
    }
}
```
- Criar uma classe para encapsular as operações de banco de dados
```dart
import 'package:sqflite/sqflite.dart';
class DB {

}
```
- Função para iniciar o banco de dados
```dart
static Future<Database> abrir() async {

  Database db =  await openDatabase("SimpleBlackJackDB", onCreate: (db, version){
        db.execute("CREATE TABLE TAB_JOGADOR (ID INTEGER PRIMARY KEY, USERNAME TEXT)");
      }, version: 1);

  return db;

}
```
- Função para inserir um jogador
```dart
static Future<int> inserir(Database db, JogadorDB jogador) async {

  var id = await db.insert('TAB_JOGADOR', jogador.toMap());
  return id;

}
```
- Função para listar
```dart
static Future<List<Map>> listar(Database db, String username) async {

  return db.query('TAB_JOGADOR', where: "USERNAME = ?", whereArgs: [username]);

}
```
- Alterar a classe `TelaPrincipal` cadastrar o jogador
```dart
DB.abrir().then((db){
    DB.listar(db, nome).then((resultado){
      if (resultado.isEmpty) {
        DB.inserir(db, JogadorDB(username: nome)).then((id){
          print('Jogador inserido: $id');
        });
      } else {
        nome = resultado.single['USERNAME'];
        print('Jogador banco de dados: $nome');
      }
      exibirTelaMesa(nome: nome);
    });
});
```
- Alterar a classe `TelaPrincipal` para verificar após o *splash* se o jogador ja existe
```dart
DB.abrir().then((db){
    DB.listar(db, nome).then((resultado){
      if (resultado.isEmpty) {
        exibirTelaCadastro();
      } else {
        nome = resultado.single['USERNAME'];
        print('Jogador banco de dados: $nome');
        exibirTelaMesa(nome: nome);
      }

    });
});
```




