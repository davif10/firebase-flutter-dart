import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() async {
  //Inicializar Firebase
  WidgetsFlutterBinding.ensureInitialized();

  Firestore db = Firestore.instance;
  var pesquisa = "a";
  QuerySnapshot snapshot = await db.collection("usuarios")
      //.where("nome", isEqualTo:"julia")
      // .where("idade", isLessThan: "21")
      // .where("idade", isGreaterThan: "18")
      // .orderBy("idade", descending: true)
      //.limit(1)
      .where("nome", isGreaterThanOrEqualTo: pesquisa)
      .where("nome", isLessThanOrEqualTo: pesquisa +"\uf8ff")
      .getDocuments();

  for(DocumentSnapshot item in snapshot.documents){
    print("Filtro nome: ${item.data}");
  }


runApp(MyApp());}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

