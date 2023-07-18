import 'package:get/get.dart';

import '../models/weight_model.dart';

class WeightDataProvider extends GetxController {
  final List<WeightData> _weightDataList = [];

  List<WeightData> get weightDataList => _weightDataList;

  void addWeightData(WeightData weightData) {
    double initialBerat = 0.0;
    double reduction = 0.0;

    if (_weightDataList.isNotEmpty) {
      initialBerat = _weightDataList.last.berat;
      reduction = weightData.berat - initialBerat;
    }

    WeightData updatedWeightData = WeightData(
      date: weightData.date,
      berat: weightData.berat,
      initialBerat: initialBerat,
      reduction: reduction,
    );

    _weightDataList.add(updatedWeightData);
    update();
  }

  void deleteWeightData(WeightData weightData) {
    _weightDataList.remove(weightData);
    update();
  }

  List<WeightData> getWeightDataList() {
    return List<WeightData>.from(_weightDataList);
  }
}
