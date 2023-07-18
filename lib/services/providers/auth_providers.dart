import 'package:diet_app/models/personal_detail_model.dart';
import 'package:diet_app/services/repository/auth_repository.dart';
import 'package:diet_app/utils/typedef.dart';

class AuthProvider {
  final AuthRepository _authRepository;

  AuthProvider(this._authRepository);

  Future<JSON> register(JSON body) async {
    var response = await _authRepository.register(body);
    return response;
  }

  Future<JSON> login(JSON body) async {
    var response = await _authRepository.login(body);
    return response;
  }

  Future<JSON> logout() async {
    var response = await _authRepository.logout();
    return response;
  }

  Future<JSON> createPersonalDetails(JSON body) async {
    var response = await _authRepository.createPersonalDetails(body);
    return response;
  }

  Future<JSON> createTarget(JSON body) async {
    var response = await _authRepository.createTarget(body);
    return response;
  }

  Future<PersonalDetailModel> showPersonalDetailById() async {
    var response = await _authRepository.showPersonalDetailById();

    ResponseResultPersonalDetailModel responseResult =
        ResponseResultPersonalDetailModel.fromJson(response);

    PersonalDetailModel result = responseResult.data!;

    return result;
  }

  Future<JSON> updatePersonalDetails(JSON body) async {
    var response = await _authRepository.updatePersonalDetails(body);
    return response;
  }
}
