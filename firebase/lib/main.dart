import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() async {
  //Inicializar Firebase
  WidgetsFlutterBinding.ensureInitialized();

  Firestore db = Firestore.instance;
  //db.collection("noticias").document("spMKcEn3wO1D7eXtQ5ZN").delete();
  // db.collection("usuarios")
  //     .document("001")
  //     .setData({
  //   "nome":"Davi",
  //   "idade": "26"
  // });

  // DocumentSnapshot snapshot = await db.collection("usuarios")
  //     .document("001")
  //     .get();
  // print("Dados: ${snapshot.data}");

  // QuerySnapshot snapshot = await db.collection("usuarios")
  //     .getDocuments();
  //print("Dados usuários: ${snapshot.documents.toString()}");

  // for(DocumentSnapshot item in snapshot.documents){
  //   //print("Dados usuários: ${item.data}");
  //   print("Dados usuários: Nome => ${item.data["nome"]} Idade => ${item.data["idade"]}");
  // }

  db.collection("usuarios")
      .snapshots().listen((event) {
        for(DocumentSnapshot item in event.documents){
          print("Dados: ${item.data}");
        }
  });

runApp(MyApp());}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

