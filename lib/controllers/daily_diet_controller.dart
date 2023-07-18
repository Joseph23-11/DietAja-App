import 'package:diet_app/models/daily_diet_model.dart';
import 'package:diet_app/services/providers/daily_diet_provider.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DailyDietController extends GetxController
    with StateMixin<DailyDietModel> {
  final DailyDietProvider _dailyDietProvider;

  DailyDietController(this._dailyDietProvider);

  Future postSearchingDailyDietByDate(String date) async {
    try {
      var now = DateTime.now();
      var formatter = DateFormat('yyyy-MM-dd');
      String formattedDate = formatter.format(now);

      if (formattedDate != date) {
        isToday.value = false;
      } else {
        isToday.value = true;
      }

      change(null, status: RxStatus.loading());
      var result = await _dailyDietProvider.postSearchingDailyDietByDate(date);

      heightBreakfast.value = 75 * result!.breakfasts!.length;
      breakfast.value = 0;
      breakfastProtein.value = 0;
      breakfastLemak.value = 0;
      breakfastKarbo.value = 0;
      for (var i = 0; i < result.breakfasts!.length; i++) {
        breakfast.value += result.breakfasts![i].kalori!.ceil();
        breakfastProtein.value += result.breakfasts![i].protein!.ceil();
        breakfastLemak.value += result.breakfasts![i].lemak!.ceil();
        breakfastKarbo.value += result.breakfasts![i].karbohidrat!.ceil();
      }

      heightLunch.value = 75 * result.lunches!.length;
      lunch.value = 0;
      lunchProtein.value = 0;
      lunchLemak.value = 0;
      lunchKarbo.value = 0;
      for (var i = 0; i < result.lunches!.length; i++) {
        lunch.value += result.lunches![i].kalori!.ceil();
        lunchProtein.value += result.lunches![i].protein!.ceil();
        lunchLemak.value += result.lunches![i].lemak!.ceil();
        lunchKarbo.value += result.lunches![i].karbohidrat!.ceil();
      }

      heightDinner.value = 75 * result.dinners!.length;
      dinner.value = 0;
      dinnerProtein.value = 0;
      dinnerLemak.value = 0;
      dinnerKarbo.value = 0;
      for (var i = 0; i < result.dinners!.length; i++) {
        dinner.value += result.dinners![i].kalori!.ceil();
        dinnerProtein.value += result.dinners![i].protein!.ceil();
        dinnerLemak.value += result.dinners![i].lemak!.ceil();
        dinnerKarbo.value += result.dinners![i].karbohidrat!.ceil();
      }

      heightSnack.value = 75 * result.snacks!.length;
      snack.value = 0;
      snackProtein.value = 0;
      snackLemak.value = 0;
      snackKarbo.value = 0;
      for (var i = 0; i < result.snacks!.length; i++) {
        snack.value += result.snacks![i].kalori!.ceil();
        snackProtein.value += result.snacks![i].protein!.ceil();
        snackLemak.value += result.snacks![i].lemak!.ceil();
        snackKarbo.value += result.snacks![i].karbohidrat!.ceil();
      }

      heightSport.value = 75 * result.dailySports!.length;

      sport.value = 0;
      for (var i = 0; i < result.dailySports!.length; i++) {
        sport.value += result.dailySports![i].kalori!.ceil();
      }
      change(result, status: RxStatus.success());
      Get.toNamed('/main-page');
      // Get.back();
    } catch (e) {
      print(e.toString());
    }
  }

  Future getAllDailyDiet() async {
    try {
      change(null, status: RxStatus.loading());
      var result = await _dailyDietProvider.getAllDailyDiet();

      change(result, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
      print('error get: ${e.toString()}');
    }
  }

  RxInt statusHari = 0.obs;

  Future getStatusHariDiet() async {
    try {
      var result = await _dailyDietProvider.getStatusHariDiet();

      statusHari.value = result!.statusHariDiet!;
    } catch (e) {
      print('error get: ${e.toString()}');
    }
  }

  RxBool isToday = true.obs;
  // breakfast
  RxInt heightBreakfast = 0.obs;
  RxInt breakfast = 0.obs;
  RxInt breakfastProtein = 0.obs;
  RxInt breakfastLemak = 0.obs;
  RxInt breakfastKarbo = 0.obs;

  // lunch
  RxInt heightLunch = 0.obs;
  RxInt lunch = 0.obs;
  RxInt lunchProtein = 0.obs;
  RxInt lunchLemak = 0.obs;
  RxInt lunchKarbo = 0.obs;

  // dinner
  RxInt heightDinner = 0.obs;
  RxInt dinner = 0.obs;
  RxInt dinnerProtein = 0.obs;
  RxInt dinnerLemak = 0.obs;
  RxInt dinnerKarbo = 0.obs;

  // snack
  RxInt heightSnack = 0.obs;
  RxInt snack = 0.obs;
  RxInt snackProtein = 0.obs;
  RxInt snackLemak = 0.obs;
  RxInt snackKarbo = 0.obs;

  // sport
  RxInt heightSport = 0.obs;
  RxInt sport = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getStatusHariDiet();
  }
}
