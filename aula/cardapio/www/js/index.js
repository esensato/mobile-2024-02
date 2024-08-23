document.addEventListener('deviceready', onDeviceReady, false);

let divPizza;
let divPreco;
let divImagem;
let cardapio;
let pizzaAtual = 0;

function onDeviceReady() {

    console.log('Running cordova-' + cordova.platformId + '@' + cordova.version);

    divImagem = document.getElementById("imagem");
    divPizza = document.getElementById("pizza");
    divPreco = document.getElementById("preco");

    const esquerda = document.getElementById("esquerda");
    const direita = document.getElementById("direita");

    esquerda.addEventListener('click', esquerdaOnClick, false);
    direita.addEventListener('click', direitaOnClick, false);

    carregarCardapio();

}

function carregarCardapio() {
    cordova.plugin.http.get('https://pedidos-pizzaria.glitch.me/pizzas', {
    }, {}, function (response) {
        // para converter a resposta em JSON
        cardapio = JSON.parse(response.data);
        atualizar();
    }, function (response) {
        alert(response.error);
    });

}

function esquerdaOnClick() {
    if (pizzaAtual > 0) {
        pizzaAtual--;
        atualizar();
    }
}

function direitaOnClick() {
    if (pizzaAtual < (cardapio.length - 1)) {
        pizzaAtual++;
        atualizar();
    }
}

function atualizar() {
    divPizza.innerHTML = cardapio[pizzaAtual].pizza;
    divPreco.innerHTML = cardapio[pizzaAtual].preco;
    divImagem.style.backgroundImage = cardapio[pizzaAtual].imagem;
}

function btnOnClick() {
    divMsg.innerHTML = 'Boa noite!';
}