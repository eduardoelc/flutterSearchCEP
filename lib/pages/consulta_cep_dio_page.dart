import 'package:flutter/material.dart';
import 'package:fluttersearchcaep/model/searches_cep_black4app_model.dart';
import 'package:fluttersearchcaep/model/viacep_model.dart';
import 'package:fluttersearchcaep/pages/cep_edit_page.dart';
import 'package:fluttersearchcaep/repositories/back4app/searches_cep_back4app_repository.dart';
import 'package:fluttersearchcaep/repositories/config/view_table_respository.dart';
import 'package:fluttersearchcaep/repositories/viacep/via_cep_repository.dart';
import 'package:fluttersearchcaep/shared/widgets/custon_appbar.dart';
import 'package:fluttersearchcaep/shared/widgets/custon_drawer.dart';

class ConsultaCepPage extends StatefulWidget {
  const ConsultaCepPage({super.key});

  @override
  State<ConsultaCepPage> createState() => _ConsultaCepPageState();
}

class _ConsultaCepPageState extends State<ConsultaCepPage> {
  var cepController = TextEditingController(text: "");
  bool loading = false;
  bool loadingCEP = false;
  bool consultaCEP = false;
  bool existeCEP = false;
  ViewSettings viewSettings = ViewSettings(fieldVisibility: {});

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
    viewSettings.fieldVisibility = await ViewSettings.createFieldVisibility(
        SearchCepBack4AppModel.getFields());
    await viewSettings.loadPreferences();
    setState(() {
      loading = false;
    });
  }

  void clear() async {
    cepController = TextEditingController(text: "");
    viacepModel = ViaCEPModel();
    consultaCEP = false;
    existeCEP = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: "Consulta CEP"),
        drawer: CustonDrawer(onConfigSaved: obterCeps),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Center(
                    child: Text(
                      "Consulta de CEP",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      (!existeCEP && viacepModel.cep != null)
                          ? Expanded(
                              child: Container(),
                            )
                          : Container(),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: cepController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: '',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String value) async {
                            var cep = value.replaceAll(RegExp(r'[^0-9]'), "");
                            if (cep.length == 8) {
                              setState(() {
                                // Ordena o item destacado para o início
                                _searchesCepBack4App.cep.sort((a, b) {
                                  if (a.cep == formatarCep(cep)) return -1;
                                  if (b.cep == formatarCep(cep)) return 1;
                                  return 0;
                                });
                                loadingCEP = true;
                              });
                              try {
                                viacepModel =
                                    await viaCepRepository.consultarCEP(cep);
                                consultaCEP = true;
                                if (viacepModel.cep != null) {
                                  existeCEP = _searchesCepBack4App.cep.any(
                                      (item) => item.cep == formatarCep(cep));
                                } else {
                                  existeCEP = false;
                                }
                              } catch (e) {
                                print('Erro ao consultar o CEP: $e');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Erro ao consultar o CEP')),
                                );
                              }
                              setState(() {
                                loadingCEP = false;
                              });
                            } else {
                              consultaCEP = false;
                              viacepModel = ViaCEPModel();
                              setState(() {});
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      (!existeCEP && viacepModel.cep != null)
                          ? Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.resolveWith<Color>(
                                    (Set<WidgetState> states) {
                                      if (states
                                          .contains(WidgetState.pressed)) {
                                        return Colors
                                            .greenAccent; // Cor ao pressionar
                                      }
                                      return Colors.green; // Cor padrão
                                    },
                                  ),
                                  foregroundColor:
                                      WidgetStateProperty.all<Color>(
                                          Colors.white), // Cor do texto
                                  shadowColor: WidgetStateProperty.all<Color>(
                                      Colors.black), // Cor da sombra
                                  elevation: WidgetStateProperty.all<double>(
                                      0), // Elevação
                                  padding: WidgetStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 12), // Padding interno
                                  ),
                                  shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          32), // Bordas arredondadas
                                      side: const BorderSide(
                                          color:
                                              Color.fromARGB(169, 76, 175, 79),
                                          width: 2), // Borda com cor
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    loading = true;
                                  });
                                  if (viacepModel.cep != null &&
                                      viacepModel.cep!.isNotEmpty) {
                                    await searchesCepRepository.postCep(
                                        SearchCepBack4AppModel.criar(
                                            viacepModel));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          backgroundColor: Colors.greenAccent,
                                          content: Text(
                                            'Cadastrado CEP com Sucesso.',
                                            style:
                                                TextStyle(color: Colors.black),
                                          )),
                                    );
                                    // Navigator.pop(context);
                                    clear();
                                    obterCeps();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Erro ao salvar o CEP. Verifique os dados.')),
                                    );
                                  }
                                  setState(() {
                                    loading = false;
                                  });
                                },
                                child: const Text(
                                  'Salvar',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  (viacepModel.cep != null)
                      ? Column(
                          children: [
                            const SizedBox(height: 10),
                            const Text(
                              "Resultado da Consulta",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              viacepModel.logradouro ?? "",
                              style: const TextStyle(fontSize: 18),
                            ),
                            Text(
                              (viacepModel.localidade != null &&
                                      viacepModel.uf != null)
                                  ? "${viacepModel.localidade} - ${viacepModel.uf}"
                                  : "",
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 5),
                            (existeCEP)
                                ? const Text(
                                    "CEP já Cadastrado.",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w700),
                                  )
                                : Container(),
                          ],
                        )
                      : Container(),
                  (!existeCEP && viacepModel.cep == null && consultaCEP)
                      ? const Column(
                          children: [
                            SizedBox(height: 15),
                            Text(
                              "CEP Não Encontrado!",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        )
                      : Container(),
                  if (loadingCEP) const CircularProgressIndicator(),
                ],
              ),
            ),
            const Center(
              child: Text(
                "Registro de CEPs Cadastrados",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationThickness: 0.8,
                    decorationColor: Colors.black54,
                    decorationStyle: TextDecorationStyle.solid),
              ),
            ),
            const SizedBox(height: 5),
            loading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: _searchesCepBack4App.cep.length,
                      itemBuilder: (context, index) {
                        final endereco = _searchesCepBack4App.cep[index];
                        return Dismissible(
                          background: Container(
                            color: Colors.red,
                            child: const Align(
                              alignment: Alignment(-0.9, 0),
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                          ),
                          secondaryBackground: Container(
                            color: Colors
                                .blue, // Cor do fundo quando editar (direita)
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            child: const Icon(Icons.edit, color: Colors.white),
                          ),
                          onDismissed: (direction) async {
                            if (direction == DismissDirection.startToEnd) {
                              try {
                                await searchesCepRepository
                                    .deleteCep(endereco.objectId);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("CEP Removido com sucesso!")),
                                );
                                obterCeps();
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Erro ao remover CEP: ${e.toString()}")),
                                );
                              }
                            } else if (direction ==
                                DismissDirection.endToStart) {
                              final updatedData = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CepEditPage(
                                      cepData: endereco,
                                      onUpdatePage: obterCeps,
                                      searchesCepRepository:
                                          searchesCepRepository),
                                ),
                              );

                              if (updatedData != null &&
                                  updatedData is SearchCepBack4AppModel) {
                                setState(() {
                                  _searchesCepBack4App.cep[index] = updatedData;
                                });
                              }
                            }
                          },
                          direction: DismissDirection.horizontal,
                          key: Key(endereco.objectId.toString()),
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                            surfaceTintColor: Colors.lightBlueAccent,
                            shadowColor: Colors.black,
                            color: Colors.white,
                            margin: const EdgeInsets.all(8),
                            child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  maxRadius: 12,
                                  child: Text(
                                    "${index + 1}", // Número do item
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                title: Text(endereco.logradouro),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (viewSettings.isFieldVisible('cep'))
                                      Text('CEP: ${endereco.cep}'),
                                    if (viewSettings
                                        .isFieldVisible('complemento'))
                                      Text(
                                          'Complemento: ${endereco.complemento}'),
                                    if (viewSettings.isFieldVisible('unidade'))
                                      Text('Unidade: ${endereco.unidade}'),
                                    if (viewSettings.isFieldVisible('bairro'))
                                      Text('Bairro: ${endereco.bairro}'),
                                    if (viewSettings
                                        .isFieldVisible('localidade'))
                                      Text('Cidade: ${endereco.localidade}'),
                                    if (viewSettings.isFieldVisible('uf'))
                                      Text('UF: ${endereco.uf}'),
                                    if (viewSettings.isFieldVisible('estado'))
                                      Text('Estado: ${endereco.estado}'),
                                    if (viewSettings.isFieldVisible('regiao'))
                                      Text('Região: ${endereco.regiao}'),
                                    if (viewSettings.isFieldVisible('ibge'))
                                      Text('IBGE: ${endereco.ibge}'),
                                    if (viewSettings.isFieldVisible('gia'))
                                      Text('GIA: ${endereco.gia}'),
                                    if (viewSettings.isFieldVisible('ddd'))
                                      Text('DDD: ${endereco.ddd}'),
                                    if (viewSettings.isFieldVisible('siafi'))
                                      Text('SIAFI: ${endereco.siafi}'),
                                    if (viewSettings
                                        .isFieldVisible('createdAt'))
                                      Text('Criado em: ${endereco.createdAt}'),
                                    if (viewSettings
                                        .isFieldVisible('updatedAt'))
                                      Text(
                                          'Atualizado em: ${endereco.updatedAt}'),
                                  ],
                                ),
                                trailing:
                                    const Icon(Icons.compare_arrows_outlined)),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

String formatarCep(String cep) {
  if (cep.length == 8) {
    return "${cep.substring(0, 5)}-${cep.substring(5)}";
  }
  return cep; // Retorna o valor original se não tiver 8 dígitos
}
