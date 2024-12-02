import 'package:flutter/material.dart';
import 'package:fluttersearchcaep/model/searches_cep_black4app_model.dart';
import 'package:fluttersearchcaep/model/viacep_model.dart';
import 'package:fluttersearchcaep/repositories/back4app/searches_cep_back4app_repository.dart';
import 'package:fluttersearchcaep/repositories/viacep/via_cep_repository.dart';

class ConsultaCepPage extends StatefulWidget {
  const ConsultaCepPage({super.key});

  @override
  State<ConsultaCepPage> createState() => _ConsultaCepPageState();
}

class _ConsultaCepPageState extends State<ConsultaCepPage> {
  var cepController = TextEditingController(text: "");
  bool loading = false;

  var viacepModel = ViaCEPModel();
  var viaCepRepository = ViaCepRepository();

  var _searchesCepBack4App = SearchesCepBlack4appModel([]);
  SearchesCepBack4appRepository searchesCepRepository =
      SearchesCepBack4appRepository();

  @override
  void initState() {
    super.initState();
    obterCeps();
  }

  void obterCeps() async {
    setState(() {
      loading = true;
    });
    _searchesCepBack4App = await searchesCepRepository.getCep();
    setState(() {
      loading = false;
    });
    print("${viacepModel.cep}: Teste");
  }

  void clear() async {
    cepController = TextEditingController(text: "");
    viacepModel = [] as ViaCEPModel;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    "Consulta de CEP",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                TextField(
                  textAlign: TextAlign.center,
                  controller: cepController,
                  keyboardType: TextInputType.number,
                  onChanged: (String value) async {
                    var cep = value.replaceAll(RegExp(r'[^0-9]'), "");
                    if (cep.length == 8) {
                      setState(() {
                        loading = true;
                      });
                      try {
                        viacepModel = await viaCepRepository.consultarCEP(cep);
                      } catch (e) {
                        print('Erro ao consultar o CEP: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Erro ao consultar o CEP')),
                        );
                      }
                      setState(() {
                        loading = false;
                      });
                    }
                  },
                ),
                (viacepModel.cep != null)
                    ? Column(
                        children: [
                          const SizedBox(height: 25),
                          Text(
                            viacepModel.logradouro ?? "",
                            style: const TextStyle(fontSize: 22),
                          ),
                          Text(
                            (viacepModel.localidade != null &&
                                    viacepModel.uf != null)
                                ? "${viacepModel.localidade} - ${viacepModel.uf}"
                                : "",
                            style: const TextStyle(fontSize: 22),
                          ),
                          const SizedBox(height: 25),
                        ],
                      )
                    : Container(),
                if (loading) const CircularProgressIndicator(),
              ],
            ),
          ),
          loading
              ? const Center(
                  child:
                      CircularProgressIndicator()) // Carregando quando a lista está sendo atualizada
              : Expanded(
                  child: ListView.builder(
                    itemCount: _searchesCepBack4App.cep.length,
                    itemBuilder: (context, index) {
                      final endereco = _searchesCepBack4App.cep[index];
                      return Card(
                        margin: EdgeInsets.all(8),
                        child: ListTile(
                          title: Text(endereco.logradouro),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('CEP: ${endereco.cep}'),
                              Text('Bairro: ${endereco.bairro}'),
                              Text('Cidade: ${endereco.localidade}'),
                              Text('UF: ${endereco.uf}'),
                              Text('Estado: ${endereco.estado}'),
                              Text('Região: ${endereco.regiao}'),
                              Text('IBGE: ${endereco.ibge}'),
                              Text('DDD: ${endereco.ddd}'),
                              Text('SIAFI: ${endereco.siafi}'),
                              Text('Criado em: ${endereco.createdAt}'),
                              Text('Atualizado em: ${endereco.updatedAt}'),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
      floatingActionButton: viacepModel.cep != null
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext bc) {
                      return AlertDialog(
                        title: const Center(
                          child: Text(
                            "Consulta de CEP",
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                        content: const SingleChildScrollView(
                            child: Text("Salvar Consulta?")),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.red, // Cor de fundo
                                  side: const BorderSide(
                                      color: Colors.red), // Borda vermelha
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        8), // Bordas arredondadas
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 20), // Espaçamento interno
                                ),
                                child: const Text(
                                  "Cancelar",
                                  style: TextStyle(
                                      color: Colors.white), // Cor do texto
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  if (viacepModel.logradouro != null &&
                                      viacepModel.logradouro!.isNotEmpty) {
                                    await searchesCepRepository.postCep(
                                        SearchCepBack4AppModel.criar(
                                            viacepModel));
                                    Navigator.pop(context);
                                    clear();
                                    obterCeps(); // Atualiza a lista de Ceps
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Erro ao salvar o CEP. Verifique os dados.')),
                                    );
                                  }
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.green, // Cor de fundo
                                  side: const BorderSide(
                                      color: Colors.green), // Borda vermelha
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        8), // Bordas arredondadas
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 20), // Espaçamento interno
                                ),
                                child: const Text(
                                  "Salvar",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Icon(Icons.save),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
    ));
  }
}
