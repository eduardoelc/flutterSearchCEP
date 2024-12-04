import 'package:flutter/material.dart';
import 'package:fluttersearchcaep/model/searches_cep_black4app_model.dart';
import 'package:fluttersearchcaep/repositories/back4app/searches_cep_back4app_repository.dart';

class CepEditPage extends StatefulWidget {
  final SearchCepBack4AppModel cepData;
  final Function()? onUpdatePage;
  final SearchesCepBack4appRepository searchesCepRepository;

  const CepEditPage(
      {super.key,
      required this.cepData,
      this.onUpdatePage,
      required this.searchesCepRepository});

  @override
  State<CepEditPage> createState() => _CepEditPageState();
}

class _CepEditPageState extends State<CepEditPage> {
  // Controladores de texto para os campos
  late TextEditingController _cepController;
  late TextEditingController _logradouroController;
  late TextEditingController _complementoController;
  late TextEditingController _unidadeController;
  late TextEditingController _bairroController;
  late TextEditingController _localidadeController;
  late TextEditingController _ufController;
  late TextEditingController _estadoController;
  late TextEditingController _regiaoController;
  late TextEditingController _ibgeController;
  late TextEditingController _giaController;
  late TextEditingController _dddController;
  late TextEditingController _siafiController;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    // Inicializar os controladores com os dados atuais do modelo
    _cepController = TextEditingController(text: widget.cepData.cep);
    _logradouroController =
        TextEditingController(text: widget.cepData.logradouro);
    _complementoController =
        TextEditingController(text: widget.cepData.complemento);
    _unidadeController = TextEditingController(text: widget.cepData.unidade);
    _bairroController = TextEditingController(text: widget.cepData.bairro);
    _localidadeController =
        TextEditingController(text: widget.cepData.localidade);
    _ufController = TextEditingController(text: widget.cepData.uf);
    _estadoController = TextEditingController(text: widget.cepData.estado);
    _regiaoController = TextEditingController(text: widget.cepData.regiao);
    _ibgeController = TextEditingController(text: widget.cepData.ibge);
    _giaController = TextEditingController(text: widget.cepData.gia);
    _dddController = TextEditingController(text: widget.cepData.ddd);
    _siafiController = TextEditingController(text: widget.cepData.siafi);
  }

  @override
  void dispose() {
    // Descartar os controladores quando a tela for descartada
    _cepController.dispose();
    _logradouroController.dispose();
    _complementoController.dispose();
    _unidadeController.dispose();
    _bairroController.dispose();
    _localidadeController.dispose();
    _ufController.dispose();
    _estadoController.dispose();
    _regiaoController.dispose();
    _ibgeController.dispose();
    _giaController.dispose();
    _dddController.dispose();
    _siafiController.dispose();
    super.dispose();
  }

  Future<void> _saveCep() async {
    setState(() {
      loading = true;
    });

    // Atualizar o modelo com os valores dos controladores
    widget.cepData
      ..cep = _cepController.text
      ..logradouro = _logradouroController.text
      ..complemento = _complementoController.text
      ..unidade = _unidadeController.text
      ..bairro = _bairroController.text
      ..localidade = _localidadeController.text
      ..uf = _ufController.text
      ..estado = _estadoController.text
      ..regiao = _regiaoController.text
      ..ibge = _ibgeController.text
      ..gia = _giaController.text
      ..ddd = _dddController.text
      ..siafi = _siafiController.text;

    try {
      await widget.searchesCepRepository.putCep(widget.cepData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Endereço salvo com sucesso!")),
      );

      if (widget.onUpdatePage != null) {
        widget.onUpdatePage!();
      }
      Navigator.pop(context, widget.cepData); // Retornar o dado atualizado
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao salvar: ${e.toString()}")),
      );
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Endereço"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (widget.onUpdatePage != null) {
              widget.onUpdatePage!();
            }
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _cepController,
                decoration: const InputDecoration(labelText: 'CEP'),
              ),
              TextField(
                controller: _logradouroController,
                decoration: const InputDecoration(labelText: 'Logradouro'),
              ),
              TextField(
                controller: _complementoController,
                decoration: const InputDecoration(labelText: 'Complemento'),
              ),
              TextField(
                controller: _unidadeController,
                decoration: const InputDecoration(labelText: 'Unidade'),
              ),
              TextField(
                controller: _bairroController,
                decoration: const InputDecoration(labelText: 'Bairro'),
              ),
              TextField(
                controller: _localidadeController,
                decoration: const InputDecoration(labelText: 'Localidade'),
              ),
              TextField(
                controller: _ufController,
                decoration: const InputDecoration(labelText: 'UF'),
              ),
              TextField(
                controller: _estadoController,
                decoration: const InputDecoration(labelText: 'Estado'),
              ),
              TextField(
                controller: _regiaoController,
                decoration: const InputDecoration(labelText: 'Região'),
              ),
              TextField(
                controller: _ibgeController,
                decoration: const InputDecoration(labelText: 'IBGE'),
              ),
              TextField(
                controller: _giaController,
                decoration: const InputDecoration(labelText: 'GIA'),
              ),
              TextField(
                controller: _dddController,
                decoration: const InputDecoration(labelText: 'DDD'),
              ),
              TextField(
                controller: _siafiController,
                decoration: const InputDecoration(labelText: 'SIAFI'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
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
                onPressed: loading ? null : _saveCep,
                child: loading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text(
                        'Salvar',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w900),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
