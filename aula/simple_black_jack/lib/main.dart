import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_black_jack/controle_principal.dart';

void main() {

  SharedPreferences.setMockInitialValues({});
  // Criar a aplicação flutter
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ControlePrincipal());
  }
}