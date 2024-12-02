import 'package:shared_preferences/shared_preferences.dart';

class ViewSettings {
  Map<String, bool> fieldVisibility;

  ViewSettings({required this.fieldVisibility});

  // Criar as chaves de visibilidade dinamicamente com base nos campos de um modelo
  static Map<String, bool> createFieldVisibility(List<String> fields) {
    Map<String, bool> fieldVisibility = {};
    for (var field in fields) {
      // Inicialmente todos os campos são visíveis
      fieldVisibility[field] = true;
    }
    return fieldVisibility;
  }

  // Carregar as configurações de visibilidade dos campos
  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    fieldVisibility.forEach((key, _) {
      bool? value = prefs.getBool(key);
      if (value != null) {
        fieldVisibility[key] = value;
      }
    });
  }

  // Salvar as configurações de visibilidade
  Future<void> savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    fieldVisibility.forEach((key, value) {
      prefs.setBool(key, value);
    });
  }

  // Alternar visibilidade de um campo
  void toggleFieldVisibility(String field) {
    if (fieldVisibility.containsKey(field)) {
      fieldVisibility[field] = !fieldVisibility[field]!;
    }
  }

  // Verificar se um campo está visível
  bool isFieldVisible(String field) {
    return fieldVisibility[field] ?? false;
  }
}
