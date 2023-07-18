import 'package:diet_app/networks/api_service.dart';
import 'package:diet_app/utils/typedef.dart';

class PerubahanBeratRepository {
  final ApiService _apiService;

  PerubahanBeratRepository(this._apiService);

  Future getPrediksi() async {
    final response = await _apiService.get(
      endpoint: '/prediksi',
      requiresAuthToken: true,
    );

    return response;
  }

  Future getPerubahanBerat() async {
    final response = await _apiService.get(
      endpoint: '/perubahan-berat',
      requiresAuthToken: true,
    );

    return response;
  }

  Future postPerubahanBerat(JSON body) async {
    final response = await _apiService.post(
      endpoint: '/perubahan-berat',
      body: body,
      requiresAuthToken: true,
    );

    return response;
  }

  Future delPerubahanBerat(int id) async {
    final response = await _apiService.delete(
      endpoint: '/perubahan-berat/$id',
      requiresAuthToken: true,
    );

    return response;
  }
}
