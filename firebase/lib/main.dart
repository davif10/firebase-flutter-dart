import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  //Inicializar Firebase
  WidgetsFlutterBinding.ensureInitialized();

  Firestore.instance.collection("usuarios")
  .document("pontuacao")
  .setData({"Davi":"250", "Ana": "190"});

  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

