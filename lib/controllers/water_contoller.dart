import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/model_air.dart';
import 'home_page_controller.dart';

class WaterController extends GetxController {
  late RxList<ModelAir> valAir;
  final carouselController = CarouselController().obs;
  RxInt currentIndex = 0.obs;
  RxInt indicatorIndex = 0.obs;
  late HomePageController homePageController;
  late RxMap<String, List<ModelAir>> waterData;

  @override
  void onInit() {
    super.onInit();
    homePageController = Get.find<HomePageController>();

    valAir = [
      ModelAir(isSelected: false, index: 0),
      ModelAir(isSelected: false, index: 1),
      ModelAir(isSelected: false, index: 2),
      ModelAir(isSelected: false, index: 3),
      ModelAir(isSelected: false, index: 4),
      ModelAir(isSelected: false, index: 5),
      ModelAir(isSelected: false, index: 6),
      ModelAir(isSelected: false, index: 7),
      ModelAir(isSelected: false, index: 8),
      ModelAir(isSelected: false, index: 9),
      ModelAir(isSelected: false, index: 10),
      ModelAir(isSelected: false, index: 11),
      ModelAir(isSelected: false, index: 12),
      ModelAir(isSelected: false, index: 13),
      ModelAir(isSelected: false, index: 14),
      ModelAir(isSelected: false, index: 15),
    ].obs;
    _loadGlassSelection();

    DateTime selectedDate =
        homePageController.dateFormat.parse(homePageController.valDate.value);
    if (isTomorrowOrLater(selectedDate)) {
      resetWaterData();
    }
  }

  bool isTomorrowOrLater(DateTime selectedDate) {
    final now = DateTime.now();
    return selectedDate.isAfter(DateTime(now.year, now.month, now.day));
  }

  void resetWaterData({bool reset = true}) async {
    if (reset) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('selectedGlasses');
      for (var glass in valAir) {
        glass.isSelected = false;
        glass.volume = null;
      }
      update();
    }
  }

  void toggleSelected(int index) {
    valAir[index].isSelected = !valAir[index].isSelected;
    updateSelectedGlassesVolume();

    for (int x = 0; x < valAir.length; x++) {
      if (x != index) {
        if (x <= index) {
          valAir[x].isSelected = true;
        } else {
          valAir[x].isSelected = false;
        }
      }
    }
  }

  double getSelectedGlassesVolume() {
    double selectedVolume = valAir
        .where((air) => air.isSelected)
        .fold(0.0, (sum, air) => sum + (air.volume ?? 0.0));
    return selectedVolume;
  }

  void updateSelectedGlassesVolume() {
    double selectedVolume = getSelectedGlassesVolume();
    if (selectedVolume > 2000.0) {
      selectedVolume = 2000.0;
    }
    int selectedCount = valAir.where((air) => air.isSelected).length;
    double volumePerGlass = selectedVolume / selectedCount;
    for (int i = 0; i < valAir.length; i++) {
      if (valAir[i].isSelected) {
        valAir[i].volume = volumePerGlass;
      } else {
        valAir[i].volume = null;
      }
    }
    valAir.refresh();
  }

  void updateCarouselIndex(int index) {
    currentIndex.value = index;

    // Set the indicator index based on the currentIndex
    indicatorIndex.value = index;

    update();
  }

  Future<void> _loadGlassSelection() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? selectedGlasses = prefs.getStringList('selectedGlasses');
    if (selectedGlasses != null) {
      for (int i = 0; i < valAir.length; i++) {
        if (selectedGlasses.contains(valAir[i].index.toString())) {
          valAir[i].isSelected = true;
        }
      }
    }
  }

  Future<void> saveGlassSelection() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> selectedGlasses = valAir
        .where((glass) => glass.isSelected)
        .map((glass) => glass.index.toString())
        .toList();
    await prefs.setStringList('selectedGlasses', selectedGlasses);
  }
}
