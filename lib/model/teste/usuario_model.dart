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

  static List<String> getFields() {
    return [
      'nome',
      'login',
      'senha',
      'tipo',
    ];
  }
}
