import 'package:diet_app/models/personal_detail_model.dart';
import 'package:diet_app/models/user_model.dart';
import 'package:diet_app/services/providers/user_provider.dart';
import 'package:diet_app/shared/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController with StateMixin<UserModel> {
  final UserProvider _userProvider;

  UserController(
    this._userProvider,
  );

  showUserById() async {
    try {
      change(null, status: RxStatus.loading());
      var result = await _userProvider.showUserById();

      usernameController.text = result.username!;
      emailController.text = result.email!;

      change(result, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  RxBool isLoading = false.obs;

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> updateUserDataById(BuildContext context) async {
    try {
      isLoading.value = true;

      final username = usernameController.text;
      final email = emailController.text;
      final password = passwordController.text;

      final body = {
        'username': username,
        'email': email,
        'password': password,
      };

      await _userProvider.updateUserDataById(body);

      isLoading.value = false;

      Get.toNamed('/success-page');
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  List<RxBool> gender = [false.obs, false.obs];
  final beratController = TextEditingController();
  final tinggiController = TextEditingController();
  final usiaController = TextEditingController();
  RxDouble beratBadan = 0.0.obs;

  PersonalDetailModel personalDetailModel = PersonalDetailModel();

  Future showPersonalDetailById() async {
    try {
      isLoading.value = true;

      personalDetailModel = await _userProvider.showPersonalDetailById();

      beratBadan.value = double.parse(personalDetailModel.beratBadan!);

      beratController.text = personalDetailModel.beratBadan.toString();
      tinggiController.text = personalDetailModel.tinggiBadan.toString();
      usiaController.text = personalDetailModel.usia.toString();

      if (personalDetailModel.jenisKelamin == 'pria') {
        gender[0].value = true;
        gender[1].value = false;
      } else {
        gender[0].value = false;
        gender[1].value = true;
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print('error ${e.toString()}');
    }
  }

  Future updatePersonalDetailById(
      int id, int ui, String gender, int bb, int tb, int usia) async {
    try {
      isLoading.value = true;

      final body = {
        'id': id,
        'user_id': ui,
        'jenis_kelamin': gender,
        'berat_badan': bb,
        'tinggi_badan': tb,
        'usia': usia,
      };

      await _userProvider.updatePersonalDetailById(body);

      Get.toNamed('/success-page');

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future postLogout(var context) async {
    try {
      isLoading.value = true;

      // await _authProvider.logout();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', '');
      await prefs.setString('password', '');

      showCustomSnackbar(context, 'Berhasil logout', Colors.greenAccent);

      Get.offAllNamed('/sign-in');

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
      if (e.toString().contains('401')) {
        showCustomSnackbar(context, 'Berhasil logout', Colors.greenAccent);
        Get.offAllNamed('/sign-in');
      }
    }
  }

  @override
  void onInit() async {
    super.onInit();
    showUserById();
    showPersonalDetailById();
  }
}
