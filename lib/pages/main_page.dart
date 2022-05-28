// ignore: unnecessary_import
import 'dart:ui';

// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findpet/animal_repository.dart';
import 'package:findpet/foto_usuario.dart';

import 'package:findpet/models/animal_model.dart';

// ignore: unused_import
import 'package:findpet/models/usuario_model.dart';
import 'package:findpet/pages/animal_page.dart';
// ignore: unused_import
import 'package:findpet/pages/inferir/inferir_page.dart';
import 'package:findpet/pages/usuario_page.dart';
import 'package:findpet/usuario.repository.dart';
import 'package:flutter/material.dart';

import '../animal_perdido_repository.dart';
import '../models/animal_perdido_model.dart';
import '../usuario_store.dart';
// ignore: unused_import
import 'dogs_perdidos_widget.dart';
import 'my_dog_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Página inicial"),
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
                          ValueListenableBuilder(
                            valueListenable: usuario,
                            builder: (BuildContext context, dynamic value,
                                Widget? child) {
                              return CircleAvatar(
                                  radius: 55.0,
                                  backgroundImage:
                                      FotoUsuario(usuario.value!).getImage());
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            usuario.value?.nome ?? "",
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
                            onPressed: () async {
                              await Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UsuarioPage(usuario: usuario.value)));
                              Navigator.of(context).pop();
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
                                color: Color(0xFFFFFFFF)),
                            label: const Text(
                              "Cadastro do animal",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            onPressed: () async {
                              await Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const AnimalPage()));
                                  setState(() {
                                    
                                  });
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
      body: Column(
        children: [
          SizedBox(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Meus cachorros cadastrados",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 150,
            child: FutureBuilder<List<AnimalModel>>(
              future: AnimalRepository().listar(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.black)),);
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(8.0),
                    itemBuilder: (context, index) {
                      List<AnimalModel> data = snapshot.data!;
                      return MyDogWidget(data[index],key: Key("${data[index].id}"),);
                    },
                  );
                }
              },
            ),
          ),
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Cachorros perdidos",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<AnimalPerdidoModel>>(
                future: AnimalPerdidoRepository().listar(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.black)),);
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(8.0),
                      itemBuilder: (context, index) {
                        List<AnimalPerdidoModel> data = snapshot.data!;
                        return DogsPerdidosWidget(data[index].animal,key: Key("${data[index].id}"),);
                      },
                    );
                  }
                },
              ),
          ),
        ],
      ),
    );
  }

  Future<void> _logout() async {
    await UsuarioRepository().logout();
  }
}
