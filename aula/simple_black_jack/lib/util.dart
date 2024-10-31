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
