import 'package:findpet/pages/inferir/chat_page.dart';
import 'package:findpet/notificacao_page.dart';
import 'package:findpet/pages/inferir/inferir_page.dart';
import 'package:findpet/pages/inferir/settings_page.dart';
import 'package:findpet/usuario.repository.dart';
import 'package:findpet/usuario_model.dart';
import 'package:flutter/material.dart';
import 'usuario_page.dart';

class MainPage extends StatelessWidget {
  final UsuarioModel? usuario;
  const MainPage(this.usuario, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Página inicial"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const InferirPage()));
        },
        child: const Icon(Icons.add_a_photo_outlined, color: Colors.white),
      ),
      drawer: Drawer(
        backgroundColor: Colors.cyan[800],
        elevation: 5,
        // ignore: avoid_unnecessary_containers
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // ignore: sized_box_for_whitespace
              Container(
                width:double.infinity,
                height: 150,
                child: Card(
                  color: Colors.black54,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const CircleAvatar(
                            radius: 55.0,
                            backgroundImage: NetworkImage("https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80")
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
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
                          icon: const Icon(Icons.edit, color: Colors.white),
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
                            icon: const Icon(Icons.notifications, color: Colors.white),
                            label: const Text(
                              "Notificações", 
                              style: TextStyle(
                                color:Colors.white, 
                                fontSize: 18,
                              ),
                            ),
                            onPressed: (){
                              Navigator.of(context).push( MaterialPageRoute(builder: (context)=>const NotificacaoPage()));
                            }, 
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          TextButton.icon(
	                          icon: const Icon(Icons.chat, color: Colors.white),
                            label: const Text(
                              "Chat", 
                              style: TextStyle(
            	                  color:Colors.white, 
                                fontSize: 18,
            	                ),
                            ),
                            onPressed: (){
                              Navigator.of(context).push( MaterialPageRoute(builder: (context)=>const ChatPage()) );
                            }, 
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          TextButton.icon(
	                          icon: const Icon(Icons.explore_outlined, color: Colors.white),
                            label: const Text(
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
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          TextButton.icon(
	                          icon: const Icon(Icons.account_circle_rounded, color: Colors.white),
                            label: const Text(
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

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.bottomRight,
                        child: IconButton(
                          onPressed: (){
                            Navigator.of(context).push( MaterialPageRoute(builder: (context)=>const SettingsPage()) );
                          }, 
                          icon: const Icon(Icons.settings, color: Colors.white),
                        )
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                        child: IconButton(
                          onPressed: (){
                            _logout();
                          }, 
                          icon: const Icon(Icons.logout, color: Colors.white),
                        )
                    ),
                  ],
                ),
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