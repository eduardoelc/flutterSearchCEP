class UsuarioModel {
  String? nome;
  String? login;
  String? senha;
  String? tipo;

  UsuarioModel({
    this.nome,
    this.login,
    this.senha,
    this.tipo,
  });

  static List<Map<String, String>> getFields() {
    return [
      {'name': 'nome', 'label': 'Nome'},
      {'name': 'login', 'label': 'Login'},
      {'name': 'tipo', 'label': 'Tipo de Usuário'}
    ];
  }
}
