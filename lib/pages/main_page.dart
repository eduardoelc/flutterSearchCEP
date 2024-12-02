import 'package:flutter/material.dart';
import 'package:fluttersearchcaep/pages/consulta_cep_dio.dart';
import 'package:fluttersearchcaep/shared/widgets/custon_drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Consulta CEP",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      drawer: const CustonDrawer(),
      body: const ConsultaCepPage(),
    );
  }
}
