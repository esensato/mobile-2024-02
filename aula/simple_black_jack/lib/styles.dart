import 'package:flutter/material.dart';

class Styles {

  // estilo para caixa de textos
  static InputDecoration getInputTextStyle({label = ''}) {
    return InputDecoration(
      border: const OutlineInputBorder(),
      labelText: label
    );
  }

  // estilo para botões
  static ButtonStyle getButtonStyle({cor = Colors.amberAccent}) {
    return ElevatedButton.styleFrom(
      backgroundColor: cor,
      shadowColor: Colors.green,
      elevation: 3,
    );
  }

  // estilo para textos
  static TextStyle getTextStyle({cor = Colors.white}) {
    return TextStyle(color: cor, fontSize: 18.0);
  }

  // estilo para caixas
  static BoxDecoration getBoxDecoration() {
    return  BoxDecoration(color: Colors.black,
        border: Border.all(color: Colors.green, width: 5.0),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)));
  }

}