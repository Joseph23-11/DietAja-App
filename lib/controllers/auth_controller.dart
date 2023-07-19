import 'package:diet_app/models/personal_detail_model.dart';
import 'package:diet_app/models/token.dart';
import 'package:diet_app/services/providers/auth_providers.dart';
import 'package:diet_app/shared/helper.dart';
import 'package:diet_app/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final AuthProvider _authProvider;

  AuthController(this._authProvider);

  RxBool isLoading = false.obs;
  RxBool isPasswordVisible = false.obs;
  bool obscureText = true;

  // register
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // onboarding2
  List<RxBool> gender = [true.obs, false.obs];
  final beratController = TextEditingController();
  final tinggiController = TextEditingController();
  final usiaController = TextEditingController();
  RxDouble bmr = 0.0.obs;

  void calcBmr(bool gender, double bb, double tb, int u) {
    if (gender) {
      bmr.value = 66 + (13.7 * bb) + (5 * tb) - (6.7 * u);
    } else {
      bmr.value = 665 + (9.6 * bb) + (1.8 * tb) - (4.7 * u);
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }

  // onboarding3
  List<RxBool> select3 = [false.obs, false.obs, false.obs, false.obs];
  RxDouble pal = 0.0.obs;

  Future setPal() async {
    if (select3[0].value == true) {
      pal.value = 1.2;
    } else if (select3[1].value == true) {
      pal.value = 1.5;
    } else if (select3[2].value == true) {
      pal.value = 1.7;
    } else if (select3[3].value == true) {
      pal.value = 1.95;
    }
  }

  RxDouble ttde = 0.0.obs;

  Future calcTdee() async {
    ttde.value = bmr.value * pal.value;
  }

  // onboarding4
  final tecBerat = TextEditingController();

  RxDouble beratAwal = 0.0.obs;
  RxDouble totalPengurangan = 0.0.obs;

  RxDouble currentValue = 0.5.obs;
  RxString currentLabel = ''.obs;

  RxInt kalori = 0.obs;
  RxInt hari = 0.obs;

  void updateSliderValue(double value) {
    currentValue.value = value;
    updateSliderLabel();
    update();
  }

  void updateSliderLabel() async {
    switch (currentValue.toString()) {
      case '0.0':
        currentLabel.value = 'Lambat';
        await calcKaloriHari(250);
        break;
      case '0.5':
        currentLabel.value = 'Normal';
        await calcKaloriHari(500);
        break;
      case '1.0':
        currentLabel.value = 'Cepat';
        await calcKaloriHari(750);
        break;
      default:
        currentLabel.value = '';
    }
  }

  Future calcKaloriHari(int defisit) async {
    double defisitTotal = 7700 * totalPengurangan.value;
    kalori.value = (ttde.value - defisit).ceil();
    hari.value = (defisitTotal / defisit).ceil();
  }

  // show personal details
  PersonalDetailModel personalDetailModel = PersonalDetailModel();
  RxDouble beratBadan = 0.0.obs;

  Future showPersonalDetailById() async {
    try {
      isLoading.value = true;

      personalDetailModel = await _authProvider.showPersonalDetailById();

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

  // update personal details
  Future updatePersonalDetailById(
    String gender,
    double bb,
    double tb,
    int usia,
    String lvl,
    double tbb,
    String td,
    int thd,
    int bugdet,
    double tpb,
  ) async {
    try {
      isLoading.value = true;

      final body = {
        'jenis_kelamin': gender,
        'berat_badan': bb,
        'tinggi_badan': tb,
        'usia': usia,
        "level_aktivitas": lvl,
        "target_berat_badan": tbb,
        "target_diet": td,
        "target_hari_diet": thd,
        "budget_kalori_harian": bugdet,
        "total_pengurangan_berat": tpb,
      };

      await _authProvider.updatePersonalDetails(body);

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  // token
  String? token;
  String? saveUsername;
  String? savePassword;

  Future postRegister() async {
    try {
      print('postregister');
      isLoading.value = true;

      final registerBody = {
        'username': usernameController.text,
        'email': emailController.text,
        'password': passwordController.text,
      };

      await _authProvider.register(registerBody);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future postLogin(
      bool isRegist, String email, String password, var context) async {
    try {
      isLoading.value = true;

      final loginBody = {
        'email': email,
        'password': password,
      };

      var response = await _authProvider.login(loginBody);

      ResponseResultToken responseResult =
          ResponseResultToken.fromJson(response);

      token = responseResult.data?.token;
      saveUsername = email;
      savePassword = password;

      if (token != null) {
        updateToken(token, saveUsername, savePassword);
      }

      if (isRegist) {
        Get.toNamed('/onboarding-page-2');
      } else {
        Get.offAndToNamed('/main-page');
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      if (e.toString().contains('401')) {
        showCustomSnackbar(context, 'Email atau Password Salah', redColor);
      }
    }
  }

  Future updateToken(
      String? myToken, String? myUsername, String? myPassword) async {
    token = myToken;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('username', myUsername!);
    await prefs.setString('password', myPassword!);

    await prefs.setString('token', token!);

    print('updateToken: $token');
  }

  Future createPersonalDetails(
      String gender, double bb, int tb, int usia) async {
    try {
      isLoading.value = true;

      final body = {
        'jenis_kelamin': gender,
        'berat_badan': bb,
        'tinggi_badan': tb,
        'usia': usia,
      };

      await _authProvider.createPersonalDetails(body);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future createTarget(
    String level,
    int tbb,
    String td,
    int thd,
    int bkh,
    int tpb,
  ) async {
    try {
      isLoading.value = true;

      switch (level) {
        case "1.2":
          level = "1";
          break;
        case "1.5":
          level = "2";
          break;
        case "1.7":
          level = "3";
          break;
        case "1.95":
          level = "4";
          break;
        default:
      }

      final body = {
        'level_aktivitas': level,
        'target_berat_badan': tbb,
        'target_diet': td,
        'target_hari_diet': thd,
        'budget_kalori_harian': bkh,
        'total_pengurangan_berat': tpb,
      };

      await _authProvider.createTarget(body);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    showPersonalDetailById();
  }
}
