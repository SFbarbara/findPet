import 'package:findPet/usuario_model.dart';
import 'package:flutter/material.dart';
import 'usuario_page.dart';

class MainPage extends StatelessWidget {
  final UsuarioModel? usuario;
  const MainPage(this.usuario, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Página inicial"),
      ),
      body: Container(),
      drawer: Drawer(
        backgroundColor: Colors.black,
        elevation: 5,
        child: Container(
          child: Column(
            children: [
              Container(
                width:double.infinity,
                height: 140,
                child: Card(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 55.0,
                            backgroundImage: NetworkImage("https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80")
                          ),
                          Text("Seu Nome"),
                        ],
                      ),
                      Positioned(
                        right: 2,
                        top: 2,
                        child: IconButton(
                          onPressed: (){
                          Navigator.of(context).push( MaterialPageRoute(builder: (context)=>UsuarioPage(usuario:usuario)) );
                          }, 
                          icon: Icon(Icons.edit),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}