import 'package:flutter/material.dart';
import 'package:fluttersearchcaep/model/searches_cep_black4app_model.dart';
import 'package:fluttersearchcaep/model/teste/cliente_model.dart';
import 'package:fluttersearchcaep/model/teste/usuario_model.dart';
import 'package:fluttersearchcaep/model/teste/venda_model.dart';
import 'package:fluttersearchcaep/repositories/config/view_table_respository.dart';

class ConfigViewTablePage extends StatefulWidget {
  const ConfigViewTablePage({super.key});

  @override
  State<ConfigViewTablePage> createState() => _ConfigViewTablePageState();
}

class _ConfigViewTablePageState extends State<ConfigViewTablePage> {
  ViewSettings viewSettings = ViewSettings(fieldVisibility: {});
  String selectedTable = 'Endereco'; // A tabela inicialmente selecionada

  // Tabelas e seus campos disponíveis
  final Map<String, List<String>> tables = {
    'Endereco': SearchCepBack4AppModel.getFields(),
    'Cliente': ClienteModel.getFields(),
    'Usuario': UsuarioModel.getFields(),
    'Venda': VendaModel.getFields(),
  };

  // Carregar as configurações de visibilidade para a tabela selecionada
  void loadSettings() {
    viewSettings.fieldVisibility =
        ViewSettings.createFieldVisibility(tables[selectedTable]!);
    viewSettings.loadPreferences();
  }

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Configuração de Visibilidade")),
      body: Column(
        children: [
          // Seletor de tabela
          DropdownButton<String>(
            value: selectedTable,
            onChanged: (String? newValue) {
              setState(() {
                selectedTable = newValue!;
                loadSettings(); // Recarrega as configurações ao mudar a tabela
              });
            },
            items: tables.keys.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Expanded(
            child: ListView(
              children: viewSettings.fieldVisibility.keys.map((field) {
                return SwitchListTile(
                  title: Text(field),
                  value: viewSettings.isFieldVisible(field),
                  onChanged: (bool value) {
                    setState(() {
                      viewSettings.toggleFieldVisibility(field);
                    });
                  },
                );
              }).toList(),
            ),
          ),
          // Botão para salvar as preferências
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () async {
                await viewSettings.savePreferences();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Preferências salvas!')),
                );
              },
              child: const Text("Salvar Configurações"),
            ),
          ),
        ],
      ),
    );
  }
}
