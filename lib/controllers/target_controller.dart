import 'package:diet_app/models/personal_detail_model.dart';
import 'package:diet_app/models/target_model.dart';
import 'package:diet_app/services/providers/user_provider.dart';
import 'package:get/get.dart';

class TargetController extends GetxController with StateMixin<TargetModel> {
  final UserProvider _userProvider;

  TargetController(this._userProvider);

  RxString karbohidrat = 'Karbohidrat'.obs;
  RxInt kalori = 0.obs;
  RxInt protein = 0.obs;
  RxInt lemak = 0.obs;
  RxInt karbo = 0.obs;

  RxDouble targetBerat = 0.0.obs;
  RxInt targetHari = 0.obs;

  showTargetById() async {
    try {
      change(null, status: RxStatus.loading());
      var result = await _userProvider.showTargetById();

      targetBerat.value = result.targetBeratBadan!.toDouble();
      targetHari.value = result.targetHariDiet!.toInt().round();
      kalori.value = result.budgetKaloriHarian!.toInt().round();
      await showPersonalDetailById();
      await calcMakroNutrisi();
      await setBatas();

      change(result, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  calcMakroNutrisi() async {
    isLoading.value = true;
    protein.value = ((0.15 * kalori.value) / 4).ceil();
    lemak.value = ((0.25 * kalori.value) / 9).ceil();
    karbo.value = ((0.65 * kalori.value) / 4).ceil();
    isLoading.value = false;
  }

  RxInt batasBreakfast = 0.obs;
  RxInt batasLunch = 0.obs;
  RxInt batasDinner = 0.obs;
  RxInt batasSnack = 0.obs;
  RxInt usia = 0.obs;
  RxString gender = ''.obs;

  setBatas() async {
    isLoading.value = true;
    if (usia.value == 1) {
      batasBreakfast.value = ((20 * kalori.value) / 100).ceil();
      batasLunch.value = ((22 * kalori.value) / 100).ceil();
      batasDinner.value = ((22 * kalori.value) / 100).ceil();
      batasSnack.value = ((36 * kalori.value) / 100).ceil();
    } else if (usia.value >= 2 && usia.value <= 4) {
      batasBreakfast.value = ((20 * kalori.value) / 100).ceil();
      batasLunch.value = ((27 * kalori.value) / 100).ceil();
      batasDinner.value = ((27 * kalori.value) / 100).ceil();
      batasSnack.value = ((37 * kalori.value) / 100).ceil();
    } else if (usia.value >= 5 && usia.value <= 10) {
      if (gender.value == 'pria') {
        batasBreakfast.value = ((22 * kalori.value) / 100).ceil();
        batasLunch.value = ((32 * kalori.value) / 100).ceil();
        batasDinner.value = ((32 * kalori.value) / 100).ceil();
        batasSnack.value = ((14 * kalori.value) / 100).ceil();
      } else {
        batasBreakfast.value = ((21 * kalori.value) / 100).ceil();
        batasLunch.value = ((31 * kalori.value) / 100).ceil();
        batasDinner.value = ((31 * kalori.value) / 100).ceil();
        batasSnack.value = ((17 * kalori.value) / 100).ceil();
      }
    } else if (usia.value >= 11 && usia.value <= 13) {
      if (gender.value == 'pria') {
        batasBreakfast.value = ((24 * kalori.value) / 100).ceil();
        batasLunch.value = ((30 * kalori.value) / 100).ceil();
        batasDinner.value = ((35 * kalori.value) / 100).ceil();
        batasSnack.value = ((11 * kalori.value) / 100).ceil();
      } else {
        batasBreakfast.value = ((22 * kalori.value) / 100).ceil();
        batasLunch.value = ((31 * kalori.value) / 100).ceil();
        batasDinner.value = ((37 * kalori.value) / 100).ceil();
        batasSnack.value = ((10 * kalori.value) / 100).ceil();
      }
    } else if (usia.value >= 14 && usia.value <= 18) {
      if (gender.value == 'pria') {
        batasBreakfast.value = ((22 * kalori.value) ~/ 100).ceil();
        batasLunch.value = ((34 * kalori.value) ~/ 100).ceil();
        batasDinner.value = ((39 * kalori.value) ~/ 100).ceil();
        batasSnack.value = ((5 * kalori.value) ~/ 100).ceil();
      } else {
        batasBreakfast.value = ((22 * kalori.value) / 100).ceil();
        batasLunch.value = ((31 * kalori.value) / 100).ceil();
        batasDinner.value = ((37 * kalori.value) / 100).ceil();
        batasSnack.value = ((10 * kalori.value) / 100).ceil();
      }
    } else if (usia.value >= 19 && usia.value <= 59) {
      if (gender.value == 'pria') {
        batasBreakfast.value = ((21 * kalori.value) / 100).ceil();
        batasLunch.value = ((33 * kalori.value) / 100).ceil();
        batasDinner.value = ((40 * kalori.value) / 100).ceil();
        batasSnack.value = ((6 * kalori.value) / 100).ceil();
      } else {
        batasBreakfast.value = ((20 * kalori.value) / 100).ceil();
        batasLunch.value = ((34 * kalori.value) / 100).ceil();
        batasDinner.value = ((39 * kalori.value) / 100).ceil();
        batasSnack.value = ((7 * kalori.value) / 100).ceil();
      }
    } else if (usia.value >= 60) {
      if (gender.value == 'pria') {
        batasBreakfast.value = ((24 * kalori.value) / 100).ceil();
        batasLunch.value = ((33 * kalori.value) / 100).ceil();
        batasDinner.value = ((41 * kalori.value) / 100).ceil();
        batasSnack.value = ((2 * kalori.value) / 100).ceil();
      } else {
        batasBreakfast.value = ((23 * kalori.value) / 100).ceil();
        batasLunch.value = ((33 * kalori.value) / 100).ceil();
        batasDinner.value = ((39 * kalori.value) / 100).ceil();
        batasSnack.value = ((5 * kalori.value) / 100).ceil();
      }
    }
    isLoading.value = false;
  }

  RxBool isLoading = false.obs;
  PersonalDetailModel personalDetailModel = PersonalDetailModel();

  Future showPersonalDetailById() async {
    try {
      personalDetailModel = await _userProvider.showPersonalDetailById();
      usia.value = int.parse(personalDetailModel.usia!);
      gender.value = personalDetailModel.jenisKelamin.toString();
    } catch (e) {
      print('error ${e.toString()}');
    }
  }

  @override
  void onInit() {
    super.onInit();
    showTargetById();
  }
}
