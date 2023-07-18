import 'package:diet_app/networks/api_service.dart';
import 'package:diet_app/utils/typedef.dart';

class SportRepository {
  final ApiService _apiService;

  SportRepository(this._apiService);

  Future getAllSport() async {
    final response = await _apiService.get(
      endpoint: '/sports',
      requiresAuthToken: true,
    );

    return response;
  }

  Future getSport() async {
    final response = await _apiService.get(
      endpoint: '/daily-sports',
      requiresAuthToken: true,
    );

    return response;
  }

  Future postSport(JSON body) async {
    final response = await _apiService.post(
      endpoint: '/daily-sports',
      body: body,
      requiresAuthToken: true,
    );

    return response;
  }

  Future delSport(int id) async {
    final response = await _apiService.delete(
      endpoint: '/daily-sports/$id',
      requiresAuthToken: true,
    );

    return response;
  }
}
