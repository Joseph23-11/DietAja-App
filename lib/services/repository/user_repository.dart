import 'package:diet_app/networks/api_service.dart';
import 'package:diet_app/utils/typedef.dart';

class UserRepository {
  final ApiService _apiService;

  UserRepository(this._apiService);

  Future showUserById() async {
    final response = await _apiService.get(
      endpoint: '/user/',
      requiresAuthToken: true,
    );

    return response;
  }

  Future updateUserDataById(JSON body) async {
    final response = await _apiService.put(
      endpoint: '/user',
      body: body,
      requiresAuthToken: true,
    );

    return response;
  }

  Future showPersonalDetailById() async {
    final response = await _apiService.get(
      endpoint: '/personal-details',
      requiresAuthToken: true,
    );

    return response;
  }

  Future updatePersonalDetailById(JSON body) async {
    final response = await _apiService.put(
      endpoint: '/personal-details',
      body: body,
      requiresAuthToken: true,
    );

    return response;
  }

  Future showTargetById() async {
    final response = await _apiService.get(
      endpoint: '/target',
      requiresAuthToken: true,
    );

    return response;
  }
}
