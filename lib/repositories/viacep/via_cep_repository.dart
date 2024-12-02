import 'package:fluttersearchcaep/model/viacep_model.dart';
import 'package:fluttersearchcaep/repositories/viacep/via_cep_custon_dio.dart';

class ViaCepRepository {
  final _CustonDio = ViaCepCustonDio();

  Future<ViaCEPModel> consultarCEP(String cep) async {
    try {
      var result = await _CustonDio.dio.get("/$cep/json/");
      return ViaCEPModel.fromJson(result.data);
    } catch (e) {
      throw e;
    }
  }
}
