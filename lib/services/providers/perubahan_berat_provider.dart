import 'package:diet_app/models/perubahan_berat_model.dart';
import 'package:diet_app/models/prediksi_model.dart';
import 'package:diet_app/services/repository/perubahan_berat_repository.dart';
import 'package:diet_app/utils/typedef.dart';

class PerubahanBeratProvider {
  final PerubahanBeratRepository _beratRepository;

  PerubahanBeratProvider(this._beratRepository);

  Future<PrediksiModel> getPrediksi() async {
    var response = await _beratRepository.getPrediksi();

    PrediksiModel responseResult = PrediksiModel.fromJson(response);

    return responseResult;
  }

  Future<List<PerubahanBeratModel>?> getPerubahanBerat() async {
    var response = await _beratRepository.getPerubahanBerat();

    ResponseResultPerubahanBeratModel responseResult =
        ResponseResultPerubahanBeratModel.fromJson(response);

    List<PerubahanBeratModel> result = responseResult.perubahanBerat!;

    return result;
  }

  Future<JSON> postPerubahanBerat(JSON body) async {
    var response = await _beratRepository.postPerubahanBerat(body);
    return response;
  }

  Future delPerubahanBerat(int id) async {
    return await _beratRepository.delPerubahanBerat(id);
  }
}
