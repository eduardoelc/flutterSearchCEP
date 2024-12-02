import 'package:fluttersearchcaep/model/viacep_model.dart';
import 'package:fluttersearchcaep/repositories/viacep/via_cep_custon_dio.dart';

class ViaCepRepository {
  final _CustonDio = ViaCepCustonDio();

  Future<ViaCEPModel> consultarCEP(String cep) async {
    var url = "/$cep/json/";
    var result = await _CustonDio.dio.get(url);
    return ViaCEPModel.fromJson(result.data);
    // if (response.statusCode == 200) {
    //   var json = jsonDecode(response.body);
    //   return ViaCEPModel.fromJson(json);
    // } else {
    //   return ViaCEPModel();
    // }
  }
}
