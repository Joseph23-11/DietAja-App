import 'package:diet_app/networks/api_service.dart';

class DailyDietRepository {
  final ApiService _apiService;

  DailyDietRepository(this._apiService);

  Future getAllDailyDiet() async {
    final response = await _apiService.get(
      endpoint: '/daily-diets',
      requiresAuthToken: true,
    );

    return response;
  }

  Future getStatusHariDiet() async {
    final response = await _apiService.get(
      endpoint: '/status',
      requiresAuthToken: true,
    );

    return response;
  }

  Future postSearchingDailyDietByDate(String date) async {
    final response = await _apiService.post(
      endpoint: '/daily-diets/search',
      body: {
        'date': date,
      },
      requiresAuthToken: true,
    );

    return response;
  }
}
