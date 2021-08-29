import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  //Inicializar Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
  String _statusUpload = "Upload não iniciado";
  String _urlImagem = null;
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
    //     print("Novo usuário: Sucesso!! Email: ${firebaseUser.user.email}");
    // }).catchError((erro){
    //   print("Novo usuário: erro $erro");
    // });
    // auth.signOut(); //Deslogar

    auth.signInWithEmailAndPassword(
        email: email,
        password: senha).then((firebaseUser){
      print("Logar usuário: Sucesso!! Email: ${firebaseUser.user.email}");
    }).catchError((erro){
      print("Logar usuário: Erro: $erro");
    });

    User usuarioAtual = await auth.currentUser;
    if(usuarioAtual != null){//Logado
      print("Usuario Atual logado email: ${usuarioAtual.email}");
    }else{//Deslogado
      print("Usuario deslogado.");
    }
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

  _uploadImagem() async{
    if(_imagem != null){
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference pastaRaiz = storage.ref();
      Reference arquivo = pastaRaiz
          .child("fotos")
          .child("foto2.jpg");

      //Fazer upload
      UploadTask task = arquivo.putFile(_imagem);

      //Controlar progresso do Upload
      task.snapshotEvents.listen((TaskSnapshot snapshot) {
        if(snapshot.state == TaskState.running){
          setState(() {
            _statusUpload = "Em progresso...";
          });

        }else if(snapshot.state == TaskState.success){
          _recuperarUrlImagem(snapshot);
          setState(() {
            _statusUpload = "Upload realizado com sucesso!";
          });

        }else if(snapshot.state == TaskState.error){
          setState(() {
            _statusUpload = "Erro ao fazer upload.";
          });
        }
      });

      //Recuperar url da imagem
      // task.onComplete.then((snapshot){
      //   _recuperarUrlImagem(snapshot);
      // });
    }
  }

  _recuperarUrlImagem(TaskSnapshot snapshot) async{
    String url = await snapshot.ref.getDownloadURL();
    print("Resultado URL: $url");

    setState(() {
      _urlImagem = url;
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
              Text(_statusUpload),
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
                  : Image.file(_imagem),

              _imagem == null
                  ? Container()
                  : ElevatedButton(
                child: Text("Upload Storage"),
                onPressed: (){
                  _uploadImagem();
                },
              ),
              _urlImagem == null
              ? Container()
              : Image.network(_urlImagem)
            ],
          ),
        ),

      ),
    );
  }
}

