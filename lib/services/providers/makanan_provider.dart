import 'package:diet_app/models/food_model.dart';
import 'package:diet_app/models/makanan_model.dart';
import 'package:diet_app/services/repository/makanan_repository.dart';
import 'package:diet_app/utils/typedef.dart';

class MakananProvider {
  final MakananRepository _makananRepository;

  MakananProvider(this._makananRepository);

  Future<List<MakananModel>?> getFood() async {
    var response = await _makananRepository.getFood();

    ResponseResultMakananModel responseResult =
        ResponseResultMakananModel.fromJson(response);

    List<MakananModel> result = responseResult.data!;

    return result;
  }

  Future<JSON> postFood(JSON body) async {
    var response = await _makananRepository.postFood(body);
    return response;
  }

  Future<List<FoodModel>?> getBreakfast() async {
    var response = await _makananRepository.getBreakfast();

    ResponseResultFoodModel responseResult =
        ResponseResultFoodModel.fromJson(response);

    List<FoodModel> result = responseResult.data!;

    return result;
  }

  Future<JSON> postBreakfast(JSON body) async {
    var response = await _makananRepository.postBreakfast(body);
    return response;
  }

  Future delBreakfast(int id) async {
    return await _makananRepository.delBreakfast(id);
  }

  Future<JSON> putBreakfast(JSON body, int id) async {
    var response = await _makananRepository.putBreakfast(body, id);
    return response;
  }

  Future<List<FoodModel>?> getLunches() async {
    var response = await _makananRepository.getLunches();

    ResponseResultFoodModel responseResult =
        ResponseResultFoodModel.fromJson(response);

    List<FoodModel> result = responseResult.data!;

    return result;
  }

  Future<JSON> postLunches(JSON body) async {
    var response = await _makananRepository.postLunches(body);
    return response;
  }

  Future delLunches(int id) async {
    return await _makananRepository.delLunches(id);
  }

  Future<JSON> putLunches(JSON body, int id) async {
    var response = await _makananRepository.putLunches(body, id);
    return response;
  }

  Future<List<FoodModel>?> getDinners() async {
    var response = await _makananRepository.getDinners();

    ResponseResultFoodModel responseResult =
        ResponseResultFoodModel.fromJson(response);

    List<FoodModel> result = responseResult.data!;

    return result;
  }

  Future<JSON> postDinners(JSON body) async {
    var response = await _makananRepository.postDinners(body);
    return response;
  }

  Future delDinners(int id) async {
    return await _makananRepository.delDinners(id);
  }

  Future<JSON> putDinners(JSON body, int id) async {
    var response = await _makananRepository.putDinners(body, id);
    return response;
  }

  Future<List<FoodModel>?> getSnacks() async {
    var response = await _makananRepository.getSnacks();

    ResponseResultFoodModel responseResult =
        ResponseResultFoodModel.fromJson(response);

    List<FoodModel> result = responseResult.data!;

    return result;
  }

  Future<JSON> postSnacks(JSON body) async {
    var response = await _makananRepository.postSnacks(body);
    return response;
  }

  Future<JSON> putSnacks(JSON body, int id) async {
    var response = await _makananRepository.putSnacks(body, id);
    return response;
  }

  Future delSnacks(int id) async {
    return await _makananRepository.delSnacks(id);
  }

  // Future<JSON> editBreakfast(int id, JSON body) async {
  //   var response = await _makananRepository.editBreakfast(id, body);
  //   return response;
  // }

  // Future<JSON> editLunch(int id, JSON body) async {
  //   var response = await _makananRepository.editLunch(id, body);
  //   return response;
  // }

  // Future<JSON> editDinner(int id, JSON body) async {
  //   var response = await _makananRepository.editDinner(id, body);
  //   return response;
  // }

  // Future<JSON> editSnack(int id, JSON body) async {
  //   var response = await _makananRepository.editSnack(id, body);
  //   return response;
  // }
}
