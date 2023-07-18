import 'package:diet_app/models/sport_model.dart';
import 'package:diet_app/services/providers/sport_providers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SportController extends GetxController with StateMixin<List<SportModel>> {
  final SportProvider _sportProvider;
  final TextEditingController _textEditingController = TextEditingController();

  SportController(this._sportProvider);

  List<SportModel> listSport = [];
  RxString searchQuery = RxString('');

  getAllSport() async {
    try {
      change(null, status: RxStatus.loading());
      var result = await _sportProvider.getAllSport();

      listSport = result!;

      change(result, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  final ValueNotifier<RxInt> valJam = ValueNotifier(1.obs);
  final ValueNotifier<RxInt> valMenit = ValueNotifier(0.obs);
  RxInt time = 0.obs;

  void searchSport(String keyword) {
    try {
      change(null, status: RxStatus.loading());
      searchQuery.value = keyword;

      if (keyword.isEmpty) {
        change(listSport, status: RxStatus.success());
      } else {
        var searchResults = listSport
            .where((sport) => sport.namaOlahraga!
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
    change(listSport, status: RxStatus.success());
  }

  @override
  void onInit() {
    super.onInit();
    getAllSport();
  }

  @override
  void onClose() {
    _textEditingController.dispose();
    super.onClose();
  }

  TextEditingController get textEditingController => _textEditingController;
}
