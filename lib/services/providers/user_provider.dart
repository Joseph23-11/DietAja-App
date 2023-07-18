import 'package:diet_app/models/personal_detail_model.dart';
import 'package:diet_app/models/target_model.dart';
import 'package:diet_app/models/user_model.dart';
import 'package:diet_app/services/repository/user_repository.dart';
import 'package:diet_app/utils/typedef.dart';

class UserProvider {
  final UserRepository _userRepository;

  UserProvider(this._userRepository);

  Future<UserModel> showUserById() async {
    var response = await _userRepository.showUserById();

    ResponseResultUserModel responseResult =
        ResponseResultUserModel.fromJson(response);

    UserModel result = responseResult.data!;

    return result;
  }

  Future<JSON> updateUserDataById(JSON body) async {
    var response = await _userRepository.updateUserDataById(body);
    return response;
  }

  Future<PersonalDetailModel> showPersonalDetailById() async {
    var response = await _userRepository.showPersonalDetailById();

    ResponseResultPersonalDetailModel responseResult =
        ResponseResultPersonalDetailModel.fromJson(response);

    PersonalDetailModel result = responseResult.data!;

    return result;
  }

  Future<JSON> updatePersonalDetailById(JSON body) async {
    var response = await _userRepository.updatePersonalDetailById(body);
    return response;
  }

  Future<TargetModel> showTargetById() async {
    var response = await _userRepository.showTargetById();

    ResponseResultTargetModel responseResult =
        ResponseResultTargetModel.fromJson(response);

    TargetModel result = responseResult.data!;

    return result;
  }
}
