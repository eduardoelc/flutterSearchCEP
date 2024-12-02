class ClienteModel {
  String? nome;
  String? email;
  String? telefone;
  String? endereco;

  ClienteModel({
    this.nome,
    this.email,
    this.telefone,
    this.endereco,
  });

  static List<String> getFields() {
    return [
      'nome',
      'email',
      'telefone',
      'endereco',
    ];
  }
}
