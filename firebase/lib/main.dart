import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
        home: Home(),
      )
  );}

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File _imagem;
  @override
  void initState() {
    super.initState();
    //cadastroLoginUsuario();
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
  
  _recuperarImagem(bool daCamera) async {
    File imagemSelecionada;
    if(daCamera){//Camera
      imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.camera);
    }else{//Galeria
      imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _imagem = imagemSelecionada;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selecionar imagem"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                  child: Text("Camera"),
                  onPressed: (){
                    _recuperarImagem(true);
                  },
              ),
              ElevatedButton(
                child: Text("Galeria"),
                onPressed: (){
                  _recuperarImagem(false);
                },
              ),
              _imagem == null
              ? Container()
                  : Image.file(_imagem)
            ],
          ),
        ),

      ),
    );
  }
}

