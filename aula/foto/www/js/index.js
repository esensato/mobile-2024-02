document.addEventListener('deviceready', onDeviceReady, false);

let preview;

function onDeviceReady() {
    document.getElementById('tirarfoto').addEventListener('click', tirarFoto);
    preview = document.getElementById('preview');
}

function onSuccess(dadoImagem) {
    preview.style.backgroundImage = "url('data:image/jpeg;base64," + dadoImagem + "')";

    cordova.plugin.http.setDataSerializer('json');
    cordova.plugin.http.post('https://pedidos-pizzaria.glitch.me/imagem', {
        imagem: "data:image/jpeg;base64," + dadoImagem
    }, {}, function (response) {
        alert(response.status);
    }, function (response) {
        alert(response.error);
    });
}

function onFail(error) {
    alert(error);
}

function tirarFoto() {

    navigator.camera.getPicture(onSuccess, onFail, {
        quality: 10,
        destinationType: Camera.DestinationType.DATA_URL
    });

}