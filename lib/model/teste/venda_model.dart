class VendaModel {
  String? produto;
  double? preco;
  int? quantidade;
  String? data;

  VendaModel({
    this.produto,
    this.preco,
    this.quantidade,
    this.data,
  });

  static List<Map<String, String>> getFields() {
    return [
      {'name': 'produto', 'label': 'Produto'},
      {'name': 'preco', 'label': 'Preço'},
      {'name': 'quantidade', 'label': 'Quantidade'},
      {'name': 'data', 'label': 'Data'}
    ];
  }
}
