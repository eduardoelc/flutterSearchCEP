import 'package:flutter/material.dart';
import 'package:fluttersearchcaep/model/searches_cep_black4app_model.dart';
import 'package:fluttersearchcaep/model/teste/cliente_model.dart';
import 'package:fluttersearchcaep/model/teste/usuario_model.dart';
import 'package:fluttersearchcaep/model/teste/venda_model.dart';
import 'package:fluttersearchcaep/repositories/config/view_table_respository.dart';
import 'package:fluttersearchcaep/shared/widgets/custon_appbar.dart';

class ConfigViewTablePage extends StatefulWidget {
  final Function()? onConfigSaved;

  const ConfigViewTablePage({super.key, this.onConfigSaved});

  @override
  State<ConfigViewTablePage> createState() => _ConfigViewTablePageState();
}

class _ConfigViewTablePageState extends State<ConfigViewTablePage> {
  ViewSettings viewSettings = ViewSettings(fieldVisibility: {});
  String selectedTable = 'Endereco';
  bool selectAll = true;
  bool saveAction = false;

  final Map<String, List<Map<String, String>>> tables = {
    'Endereco': SearchCepBack4AppModel.getFields(),
    'Cliente': ClienteModel.getFields(),
    'Usuario': UsuarioModel.getFields(),
    'Venda': VendaModel.getFields(),
  };

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  loadSettings() async {
    viewSettings.fieldVisibility =
        await ViewSettings.createFieldVisibility(tables[selectedTable]!);
    await viewSettings.loadPreferences();

    selectAll = viewSettings.fieldVisibility.values.every((value) => value);
    setState(() {});
  }

  void _toggleAll(bool value) {
    setState(() {
      selectAll = value;
    });
    viewSettings.saveAllPreferences(value);
    loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: "Configuração de Visibilidade"),
        body: Column(
          children: [
            DropdownButton<String>(
              value: selectedTable,
              onChanged: (String? newValue) {
                setState(() {
                  selectedTable = newValue!;
                  loadSettings();
                });
              },
              items: tables.keys.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.pressed)) {
                        return selectAll
                            ? Colors.redAccent
                            : Colors.greenAccent;
                      }
                      return selectAll ? Colors.red : Colors.green;
                    },
                  ),
                  foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  shadowColor: WidgetStateProperty.all<Color>(Colors.black),
                  elevation: WidgetStateProperty.all<double>(8),
                  padding: WidgetStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                      side: const BorderSide(
                          color: Color.fromARGB(169, 5, 5, 5), width: 2),
                    ),
                  ),
                ),
                onPressed: () {
                  _toggleAll(!selectAll);
                  if (widget.onConfigSaved != null) {
                    widget.onConfigSaved!();
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Preferências salvas!')),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    selectAll
                        ? const Icon(Icons.indeterminate_check_box_outlined)
                        : const Icon(Icons.check_box_outlined),
                    const SizedBox(width: 8),
                    Text(selectAll ? "Desmarcar Tudo" : "Selecionar Tudo"),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: tables[selectedTable]!.map((field) {
                  bool valid = viewSettings.isFieldVisible(field['name']!);
                  return SwitchListTile(
                    title: Text(field['label']!),
                    value: valid,
                    onChanged: (bool value) {
                      setState(() {
                        viewSettings.updateFieldVisibility(
                            field['name']!, value);
                        saveAction = true;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            if (saveAction)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.pressed)) {
                          return Colors.greenAccent; // Cor ao pressionar
                        }
                        return Colors.green; // Cor padrão
                      },
                    ),
                    foregroundColor: WidgetStateProperty.all<Color>(
                        Colors.white), // Cor do texto
                    shadowColor: WidgetStateProperty.all<Color>(
                        Colors.black), // Cor da sombra
                    elevation: WidgetStateProperty.all<double>(0), // Elevação
                    padding: WidgetStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12), // Padding interno
                    ),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(32), // Bordas arredondadas
                        side: const BorderSide(
                            color: Color.fromARGB(169, 76, 175, 79),
                            width: 2), // Borda com cor
                      ),
                    ),
                  ),
                  onPressed: () async {
                    await viewSettings.savePreferences();
                    if (widget.onConfigSaved != null) {
                      widget.onConfigSaved!();
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Preferências salvas!')),
                    );
                    saveAction = false;
                    setState(() {});
                  },
                  child: const Text("Salvar Alteração"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
