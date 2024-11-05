import 'package:calculadora/app/app_module.dart';
import 'package:calculadora/app/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() {
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}

//falta, poder realizar um calculo com mais de 1 operação: 2 x 5 + 3 x 4 = ...
//falta fazer os numeros com virgula serem calculados
//falta fazer a porcentagem funcionar devidamente