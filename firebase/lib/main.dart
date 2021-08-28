import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() async {
  //Inicializar Firebase
  WidgetsFlutterBinding.ensureInitialized();

  Firestore db = Firestore.instance;
  /*
  db.collection("usuarios")
  .document("001")
  .setData({
    "nome": "Davi",
    "idade": "31"
  });
  */

  // DocumentReference ref = await db.collection("noticias")
  // .add(
  //     {
  //       "titulo": "Criada moeda virtual!",
  //       "descricao": "Texto de exemplo..."
  //     }
  // );
  // print("Item salvo: ${ref.documentID}");

  db.collection("noticias")
      .document("spMKcEn3wO1D7eXtQ5ZN")
      .setData(
      {
        "titulo": "Criada moeda virtual!",
        "descricao": "Texto de exemplo alterado..."
      });

runApp(MyApp());}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

