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

  static List<String> getFields() {
    return [
      'produto',
      'preco',
      'quantidade',
      'data',
    ];
  }
}
