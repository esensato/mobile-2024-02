import 'dart:io';
import 'package:image/image.dart';

Image cropImage(Image originalImage, int startX, int startY, int width, int height) {
  // Verifica se a posição e dimensões estão dentro dos limites da imagem original
  if (startX < 0 || startY < 0 || startX + width > originalImage.width || startY + height > originalImage.height) {
    throw Exception("As dimensões ou posições estão fora dos limites da imagem.");
  }

  // Recorta a subimagem
  Image croppedImage = copyCrop(originalImage, startX, startY, width, height);
  return croppedImage;
}

void main() {
  // Carrega a imagem original (substitua pelo caminho da sua imagem)
  File imageFile = File('card-deck.png');
  Image originalImage = decodeImage(imageFile.readAsBytesSync())!;

  // Define a posição e tamanho do recorte
  // int startX = 0;
  // int startY = 0;
  // int width = 98;
  // int height = 153;

  int startX = 98;
  int startY = 153;
  int width = 98;
  int height = 153;

  // Chama a função de recorte
  Image croppedImage = cropImage(originalImage, startX, startY, width, height);

  // Salva a subimagem recortada
  File('cropped_image.png').writeAsBytesSync(encodePng(croppedImage));
}
