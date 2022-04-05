import 'package:findPet/usuario.repository.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(750.0),
        child: IconButton(
          onPressed: (){}, 
          icon: const Icon(
            Icons.add_a_photo_outlined, 
            color: Colors.white, 
            size: 40,
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.cyan[800],
        elevation: 5,
        child: Container(
          child: Column(
            children: [
              Container(
                width:double.infinity,
                height: 150,
                child: Card(
                  color: Colors.black54,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 55.0,
                            backgroundImage: NetworkImage("https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80")
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Seu nome", 
                            style: TextStyle(
                              color:Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        right: 2,
                        top: 2,
                        child: IconButton(
                          onPressed: (){
                          Navigator.of(context).push( MaterialPageRoute(builder: (context)=>UsuarioPage(usuario:usuario)) );
                          }, 
                          icon: Icon(Icons.edit, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[ 
                      Row(
                        children: [
                          TextButton.icon(
                            icon: Icon(Icons.notifications, color: Colors.white),
                            label: const Text(
                              "Notificações", 
                              style: TextStyle(
                                color:Colors.white, 
                                fontSize: 18,
                              ),
                            ),
                            onPressed: (){
                              
                            }, 
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          TextButton.icon(
	                          icon: Icon(Icons.chat, color: Colors.white),
                            label: Text(
                              "Chat", 
                              style: TextStyle(
            	                  color:Colors.white, 
                                fontSize: 18,
            	                ),
                            ),
                            onPressed: (){

                            }, 
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          TextButton.icon(
	                          icon: Icon(Icons.explore_outlined, color: Colors.white),
                            label: Text(
                              "Explorar", 
                              style: TextStyle(
            	                  color:Colors.white, 
                                fontSize: 18,
            	                ),
                            ),
                            onPressed: (){
                              
                            }, 
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          TextButton.icon(
	                          icon: Icon(Icons.account_circle_rounded, color: Colors.white),
                            label: Text(
                              "Perfil", 
                              style: TextStyle(
            	                  color:Colors.white, 
                                fontSize: 18,
            	                ),
                            ),
                            onPressed: (){
                              
                            }, 
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 600,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.bottomRight,
                      child: IconButton(
                        onPressed: (){}, 
                        icon: Icon(Icons.settings, color: Colors.white),
                      )
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                      child: IconButton(
                        onPressed: (){
                          _logout();
                        }, 
                        icon: Icon(Icons.logout, color: Colors.white),
                      )
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _logout() async {
    await UsuarioRepository().logout();
  }
}