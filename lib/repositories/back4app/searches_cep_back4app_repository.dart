import 'package:fluttersearchcaep/model/searches_cep_black4app_model.dart';
import 'package:fluttersearchcaep/repositories/back4app/back4app_custon_dio.dart';

class SearchesCepBack4appRepository {
  final _CustonDio = Back4appCustonDio();

  SearchesCepBack4appRepository();

  Future<SearchesCepBlack4appModel> getCep() async {
    try {
      var result = await _CustonDio.dio.get("/Searches_Cep");
      return SearchesCepBlack4appModel.fromJson(result.data);
    } catch (e) {
      throw e;
    }
  }

  Future<void> postCep(SearchCepBack4AppModel searchCepBack4AppModel) async {
    try {
      await _CustonDio.dio
          .post("/Searches_Cep", data: searchCepBack4AppModel.toJsonEndpoint());
    } catch (e) {
      throw e;
    }
  }

  Future<void> putCep(SearchCepBack4AppModel searchCepBack4AppModel) async {
    try {
      await _CustonDio.dio.put(
          "/Searches_Cep/${searchCepBack4AppModel.objectId}",
          data: searchCepBack4AppModel.toJsonEndpoint());
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteCep(String objectId) async {
    try {
      await _CustonDio.dio.delete("/Searches_Cep/${objectId}");
    } catch (e) {
      throw e;
    }
  }
}
