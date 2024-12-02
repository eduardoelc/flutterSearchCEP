import 'package:fluttersearchcaep/model/viacep_model.dart';

class SearchesCepBlack4appModel {
  List<SearchCepBack4AppModel> cep = [];

  SearchesCepBlack4appModel(this.cep);

  SearchesCepBlack4appModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      cep = <SearchCepBack4AppModel>[];
      json['results'].forEach((v) {
        cep.add(SearchCepBack4AppModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = cep.map((v) => v.toJson()).toList();
    return data;
  }
}

class SearchCepBack4AppModel {
  String objectId = "";
  String cep = "";
  String logradouro = "";
  String complemento = "";
  String unidade = "";
  String bairro = "";
  String localidade = "";
  String uf = "";
  String estado = "";
  String regiao = "";
  String ibge = "";
  String gia = "";
  String ddd = "";
  String siafi = "";
  String createdAt = "";
  String updatedAt = "";

  SearchCepBack4AppModel(
      this.objectId,
      this.cep,
      this.logradouro,
      this.complemento,
      this.unidade,
      this.bairro,
      this.localidade,
      this.uf,
      this.estado,
      this.regiao,
      this.ibge,
      this.gia,
      this.ddd,
      this.siafi,
      this.createdAt,
      this.updatedAt);

  SearchCepBack4AppModel.criar(ViaCEPModel json) {
    cep = json.cep!;
    logradouro = json.logradouro!;
    complemento = json.complemento!;
    unidade = json.unidade!;
    bairro = json.bairro!;
    localidade = json.localidade!;
    uf = json.uf!;
    estado = json.estado!;
    regiao = json.regiao!;
    ibge = json.ibge!;
    gia = json.gia!;
    ddd = json.ddd!;
    siafi = json.siafi!;
  }

  SearchCepBack4AppModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    cep = json['cep'];
    logradouro = json['logradouro'];
    complemento = json['complemento'];
    unidade = json['unidade'];
    bairro = json['bairro'];
    localidade = json['localidade'];
    uf = json['uf'];
    estado = json['estado'];
    regiao = json['regiao'];
    ibge = json['ibge'];
    gia = json['gia'];
    ddd = json['ddd'];
    siafi = json['siafi'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['complemento'] = complemento;
    data['unidade'] = unidade;
    data['bairro'] = bairro;
    data['localidade'] = localidade;
    data['uf'] = uf;
    data['estado'] = estado;
    data['regiao'] = regiao;
    data['ibge'] = ibge;
    data['gia'] = gia;
    data['ddd'] = ddd;
    data['siafi'] = siafi;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  Map<String, dynamic> toJsonEndpoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['complemento'] = complemento;
    data['unidade'] = unidade;
    data['bairro'] = bairro;
    data['localidade'] = localidade;
    data['uf'] = uf;
    data['estado'] = estado;
    data['regiao'] = regiao;
    data['ibge'] = ibge;
    data['gia'] = gia;
    data['ddd'] = ddd;
    data['siafi'] = siafi;
    return data;
  }

  // Retorna a lista de campos do Endereço para gerar a configuração de visibilidade
  static List<String> getFields() {
    return [
      'cep',
      'logradouro',
      'complemento',
      'unidade',
      'bairro',
      'localidade',
      'uf',
      'estado',
      'regiao',
      'ibge',
      'gia',
      'ddd',
      'siafi',
      'createdAt',
      'updatedAt',
    ];
  }
}
