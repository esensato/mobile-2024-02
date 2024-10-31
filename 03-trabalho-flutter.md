## Par ou Ímpar
- Criar um simples jogo de par ou ímpar com os seguintes casos de uso:
    - O jogador deve informar seu nome, o valor da aposta, um número (entre 1 e 5) e se deseja par ou ímpar;
    - Uma lista dos jogadores que já apostaram deve ser exibida
    - O jogador seleciona qual será o seu oponente na lista
    - As apostas são comparadas e o resultado exibido
    - Para o vencedor o valor da aposta é creditado e para o perdedor debitado
    - O jogador deverá visualizar seus pontos atuais
    - Para montar a lista dos jogadores disponíveis utillizar uma [ListView](https://api.flutter.dev/flutter/widgets/ListView-class.html)

    ```javascript
    return ListView.builder(
    itemBuilder: (context, id){
        return
        Padding(padding: const EdgeInsets.all(2.0),
        child:  ListTile(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
            key: Key(id.toString()),
            tileColor: Colors.black12,
            title: Text(itens[id]['name']),
            subtitle: Text(itens[id]['web_pages'][0]),
            onTap: (){
            callback(itens[id]);
            },
            trailing: const Icon(Icons.ads_click),
        )
        );
    },
    itemCount: itens.length,
    shrinkWrap: true,
    padding: const EdgeInsets.all(5.0)
    );
    ```
### Endpoints

- POST `https://par-impar.glitch.me/novo`
- Cadastra um novo jogador
- Parâmetros do body:
    - `username`: identificação do jogador
- Retorno:
    ```json
    {
        "usuarios": [
            {
                "username": "Edson",
                "pontos": 1000
            }
        ]
    }
    ```
- POST `https://par-impar.glitch.me/aposta`
- Efetuar a aposta
- Parâmetros do body:
    - `username`: identificação do jogador
    - `valor`: valor da aposta
    - `parimpar`: 2 - par e 1 - ímpar
    - `numero`: número do par ou ímpar
- Retorno:
    ```json
    {
        "msg": "Aposta realizada: 100"
    }
    ```
- GET `https://par-impar.glitch.me/jogadores`
- Lista todos os jogadores já cadastrados
- Retorno:
    ```json
    {
        "jogadores": [
            {
                "username": "Edson",
                "pontos": 1000
            }
        ]
    }
    ```
- GET `https://par-impar.glitch.me/jogar/username1/username2`
- Efetiva o jogo do par ou ímpar conforme parâmetros dos jogadores identificados pelos parâmetros `username1` e `username2`
- Retorno:
    ```json
    {
        "vencedor": {
            "username": "Maria",
            "valor": "100",
            "parimpar": 2,
            "numero": 3
        },
        "perdedor": {
            "username": "Edson",
            "valor": "100",
            "parimpar": 1,
            "numero": 3
        }
    }
    ```
- GET `https://par-impar.glitch.me/pontos/username`
- Obtém os pontos atuais do jogador identificado na URL pelo `username`
- Retorno:
    ```json
    {
        "username": "Edson",
        "pontos": 1100
    }
    ```