import 'package:diet_app/models/makanan_model.dart';
import 'package:diet_app/services/providers/makanan_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MakananController extends GetxController
    with StateMixin<List<MakananModel>> {
  final MakananProvider _makananProvider;

  MakananController(this._makananProvider);

  final TextEditingController _textEditingController = TextEditingController();

  final porsiTextController = TextEditingController();
  RxDouble valPorsi = 1.0.obs;
  RxString searchQuery = RxString('');

  List<MakananModel> listMakanan = [];

  getFood() async {
    try {
      change(null, status: RxStatus.loading());
      var result = await _makananProvider.getFood();

      listMakanan = result!;

      change(result, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  final namaController = TextEditingController();
  final beratController = TextEditingController();
  final kaloriController = TextEditingController();
  final karboController = TextEditingController();
  final lemakController = TextEditingController();
  final proteinController = TextEditingController();
  final ukuranController = TextEditingController();

  postFood(String nama, int berat, double kalori, double karbo, double lemak,
      double protein, String ukuran) async {
    final body = <String, dynamic>{
      "nama_makanan": nama,
      "berat_makanan": berat,
      "kalori": kalori,
      "protein": protein,
      "lemak": lemak,
      "karbohidrat": karbo,
      "ukuran": ukuran,
    };
    try {
      await _makananProvider.postFood(body);

      Get.toNamed('/main-page');
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  void searchMakanan(String keyword) {
    try {
      change(null, status: RxStatus.loading());
      searchQuery.value = keyword;

      if (keyword.isEmpty) {
        change(listMakanan, status: RxStatus.success());
      } else {
        var searchResults = listMakanan
            .where((sport) => sport.namaMakanan!
                .toLowerCase()
                .contains(keyword.toLowerCase()))
            .toList();

        change(searchResults, status: RxStatus.success());
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  void clearSearch() {
    searchQuery.value = '';
    _textEditingController.clear();
    change(listMakanan, status: RxStatus.success());
  }

  @override
  void onInit() {
    super.onInit();
    getFood();
    porsiTextController.text = valPorsi.value.toStringAsFixed(2);
  }

  @override
  void onClose() {
    _textEditingController.dispose();
    super.onClose();
  }

  TextEditingController get textEditingController => _textEditingController;
}
