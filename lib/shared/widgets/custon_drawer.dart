import 'package:flutter/material.dart';
import 'package:fluttersearchcaep/pages/config/view_table_page.dart';

class CustonDrawer extends StatelessWidget {
  final Function()? onConfigSaved;

  const CustonDrawer({super.key, required this.onConfigSaved});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                context: context,
                builder: (BuildContext bc) {
                  return Wrap(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: const Text("Camera"),
                        leading: const Icon(Icons.camera),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: const Text("Galeria"),
                        leading: const Icon(Icons.image_outlined),
                      )
                    ],
                  );
                },
              );
            },
            child: const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25.0,
                foregroundImage: NetworkImage(
                    "https://play-lh.googleusercontent.com/KZ2VZgEIrHX5q1DZhqSgzW9707zXAjdw8N8AUy6t57wOd7kQdWoo1Iedr_lsV77t_io=w600-h300-pc0xffffff-pd"),
              ),
              accountName: Text("Email"),
              accountEmail: Text("Email@email.com"),
            ),
          ),
          SizedBox(
            height: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              alignment: Alignment.center,
              child: const Text(
                "Menu",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
            ),
          ),
          const Divider(),
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              width: double.infinity,
              child: const Row(
                children: [
                  Icon(Icons.settings),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Configuração"),
                ],
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConfigViewTablePage(
                      onConfigSaved:
                          onConfigSaved // Passa o callback para a ConfigPage
                      ),
                ),
              );
            },
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              width: double.infinity,
              child: const Row(
                children: [
                  Icon(Icons.exit_to_app),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Sair")
                ],
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext bc) {
                  return AlertDialog(
                    alignment: Alignment.center,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: const Text(
                      "Meu App",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    content: const Wrap(
                      children: [
                        Text("Deseja realmente sair do aplicativo?"),
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Não")),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Sim"),
                      )
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
