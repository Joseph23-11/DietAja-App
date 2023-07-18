import 'package:diet_app/networks/api_service.dart';
import 'package:diet_app/utils/typedef.dart';

class AuthRepository {
  final ApiService _apiService;

  AuthRepository(this._apiService);

  Future register(JSON body) async {
    final response = await _apiService.post(
      endpoint: '/register',
      body: body,
    );

    return response;
  }

  Future login(JSON body) async {
    final response = await _apiService.post(
      endpoint: '/login',
      body: body,
    );

    return response;
  }

  Future logout() async {
    final response = await _apiService.post(
      endpoint: '/logout',
      requiresAuthToken: true,
    );

    return response;
  }

  Future createPersonalDetails(JSON body) async {
    final response = await _apiService.post(
      endpoint: '/personal-details',
      body: body,
      requiresAuthToken: true,
    );

    return response;
  }

  Future createTarget(JSON body) async {
    final response = await _apiService.post(
      endpoint: '/target',
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

  Future updatePersonalDetails(JSON body) async {
    final response = await _apiService.put(
      endpoint: '/personal-details',
      body: body,
      requiresAuthToken: true,
    );

    return response;
  }
}
