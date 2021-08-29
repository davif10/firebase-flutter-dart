import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() async {
  //Inicializar Firebase
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseAuth auth = FirebaseAuth.instance;
  String email = "davi2@gmail.com";
  String senha = "123456";
  // auth.createUserWithEmailAndPassword(
  //     email: email, password: senha
  // ).then((firebaseUser){
  //     print("Novo usuário: Sucesso!! Email: ${firebaseUser.email}");
  // }).catchError((erro){
  //   print("Novo usuário: erro $erro");
  // });
  FirebaseUser usuarioAtual = await auth.currentUser();
  if(usuarioAtual != null){//Logado
    print("Usuario Atual logado email: ${usuarioAtual.email}");
  }else{//Deslogado
    print("Usuario deslogado.");
  }

  runApp(
      MaterialApp(
        home: MyApp(),
      )
  );}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    cadastroLoginUsuario();
  }

  cadastroLoginUsuario() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    String email = "davi2@gmail.com";
    String senha = "123456";
    // auth.createUserWithEmailAndPassword(
    //     email: email, password: senha
    // ).then((firebaseUser){
    //     print("Novo usuário: Sucesso!! Email: ${firebaseUser.email}");
    // }).catchError((erro){
    //   print("Novo usuário: erro $erro");
    // });
    //auth.signOut(); //Deslogar

    auth.signInWithEmailAndPassword(
        email: email,
        password: senha).then((firebaseUser){
      print("Logar usuário: Sucesso!! Email: ${firebaseUser.email}");
    }).catchError((erro){
      print("Logar usuário: Erro: $erro");
    });

    // FirebaseUser usuarioAtual = await auth.currentUser();
    // if(usuarioAtual != null){//Logado
    //   print("Usuario Atual logado email: ${usuarioAtual.email}");
    // }else{//Deslogado
    //   print("Usuario deslogado.");
    // }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase"),
      ),
      body: Container(

      ),
    );
  }
}

