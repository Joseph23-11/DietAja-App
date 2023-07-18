import 'package:diet_app/networks/api_service.dart';
import 'package:diet_app/utils/typedef.dart';

class MakananRepository {
  final ApiService _apiService;

  MakananRepository(this._apiService);

  Future getFood() async {
    final response = await _apiService.get(
      endpoint: '/food',
      requiresAuthToken: true,
    );

    return response;
  }

  Future postFood(JSON body) async {
    final response = await _apiService.post(
      endpoint: '/food',
      body: body,
      requiresAuthToken: true,
    );

    return response;
  }

  Future getBreakfast() async {
    final response = await _apiService.get(
      endpoint: '/breakfasts',
      requiresAuthToken: true,
    );

    return response;
  }

  Future postBreakfast(JSON body) async {
    final response = await _apiService.post(
      endpoint: '/breakfasts',
      body: body,
      requiresAuthToken: true,
    );

    return response;
  }

  Future delBreakfast(int id) async {
    final response = await _apiService.delete(
      endpoint: '/breakfasts/$id',
      requiresAuthToken: true,
    );

    return response;
  }

  Future putBreakfast(JSON body, int id) async {
    final response = await _apiService.put(
      endpoint: '/breakfasts/$id',
      body: body,
      requiresAuthToken: true,
    );

    return response;
  }

  Future getLunches() async {
    final response = await _apiService.get(
      endpoint: '/lunches',
      requiresAuthToken: true,
    );

    return response;
  }

  Future postLunches(JSON body) async {
    final response = await _apiService.post(
      endpoint: '/lunches',
      body: body,
      requiresAuthToken: true,
    );

    return response;
  }

  Future delLunches(int id) async {
    final response = await _apiService.delete(
      endpoint: '/lunches/$id',
      requiresAuthToken: true,
    );

    return response;
  }

  Future putLunches(JSON body, int id) async {
    final response = await _apiService.put(
      endpoint: '/lunches/$id',
      body: body,
      requiresAuthToken: true,
    );

    return response;
  }

  Future getDinners() async {
    final response = await _apiService.get(
      endpoint: '/dinners',
      requiresAuthToken: true,
    );

    return response;
  }

  Future postDinners(JSON body) async {
    final response = await _apiService.post(
      endpoint: '/dinners',
      body: body,
      requiresAuthToken: true,
    );

    return response;
  }

  Future delDinners(int id) async {
    final response = await _apiService.delete(
      endpoint: '/dinners/$id',
      requiresAuthToken: true,
    );

    return response;
  }

  Future putDinners(JSON body, int id) async {
    final response = await _apiService.put(
      endpoint: '/dinners/$id',
      body: body,
      requiresAuthToken: true,
    );

    return response;
  }

  Future getSnacks() async {
    final response = await _apiService.get(
      endpoint: '/snacks',
      requiresAuthToken: true,
    );

    return response;
  }

  Future postSnacks(JSON body) async {
    final response = await _apiService.post(
      endpoint: '/snacks',
      body: body,
      requiresAuthToken: true,
    );

    return response;
  }

  Future delSnacks(int id) async {
    final response = await _apiService.delete(
      endpoint: '/snacks/$id',
      requiresAuthToken: true,
    );

    return response;
  }

  Future putSnacks(JSON body, int id) async {
    final response = await _apiService.put(
      endpoint: '/snacks/$id',
      body: body,
      requiresAuthToken: true,
    );

    return response;
  }

  // Future editBreakfast(int id, JSON body) async {
  //   final response = await _apiService.put(
  //     endpoint: '/breakfasts/$id',
  //     body: body,
  //     requiresAuthToken: true,
  //   );

  //   return response;
  // }

  // Future editLunch(int id, JSON body) async {
  //   final response = await _apiService.put(
  //     endpoint: '/lunches/$id',
  //     body: body,
  //     requiresAuthToken: true,
  //   );

  //   return response;
  // }

  // Future editDinner(int id, JSON body) async {
  //   final response = await _apiService.put(
  //     endpoint: '/dinners/$id',
  //     body: body,
  //     requiresAuthToken: true,
  //   );

  //   return response;
  // }

  // Future editSnack(int id, JSON body) async {
  //   final response = await _apiService.put(
  //     endpoint: '/snacks/$id',
  //     body: body,
  //     requiresAuthToken: true,
  //   );

  //   return response;
  // }
}
