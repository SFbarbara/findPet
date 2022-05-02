import 'package:findpet/foto_usuario.dart';
import 'package:findpet/models/usuario_model.dart';
import 'package:findpet/pages/animal_page.dart';
import 'package:findpet/pages/inferir/inferir_page.dart';
import 'package:findpet/pages/usuario_page.dart';
import 'package:findpet/usuario.repository.dart';
import 'package:flutter/material.dart';

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
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const InferirPage()));
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
                width: double.infinity,
                height: 150,
                child: Card(
                  color: Colors.black54,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          CircleAvatar(
                              radius: 55.0,
                              backgroundImage:
                                  FotoUsuario(usuario!).getImage()),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            usuario?.nome ?? "",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
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
                    children: [
                      Row(
                        children: [
                          TextButton.icon(
                            icon: const Icon(Icons.account_circle_rounded,
                                color: Colors.white),
                            label: const Text(
                              "Perfil",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      UsuarioPage(usuario: usuario)));
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
                            icon: const Icon(Icons.add_to_photos_rounded,
                                color: Colors.white),
                            label: const Text(
                              "Cadastro do animal",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const AnimalPage()));
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          onPressed: () {
                            _logout();
                          },
                          icon: const Icon(Icons.logout, color: Colors.white),
                        )),
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
