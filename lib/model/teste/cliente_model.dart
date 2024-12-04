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

  static List<Map<String, String>> getFields() {
    return [
      {'name': 'nome', 'label': 'Nome'},
      {'name': 'email', 'label': 'Email'},
      {'name': 'telefone', 'label': 'Telefone'}
    ];
  }
}
