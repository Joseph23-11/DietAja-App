import 'package:diet_app/models/daily_diet_model.dart';
import 'package:diet_app/models/status_diet_model.dart';
import 'package:diet_app/services/repository/daily_diet_repository.dart';

class DailyDietProvider {
  final DailyDietRepository _dailyDietRepository;

  DailyDietProvider(this._dailyDietRepository);

  Future<DailyDietModel?> getAllDailyDiet() async {
    var response = await _dailyDietRepository.getAllDailyDiet();

    ResponseResultDailyDietModel responseResult =
        ResponseResultDailyDietModel.fromJson(response);

    DailyDietModel result = responseResult.data!;

    return result;
  }

  Future<StatusDiet?> getStatusHariDiet() async {
    var response = await _dailyDietRepository.getStatusHariDiet();

    ResponseResultStatusDietModel responseResult =
        ResponseResultStatusDietModel.fromJson(response);

    StatusDiet result = responseResult.data!;

    return result;
  }

  Future<DailyDietModel?> postSearchingDailyDietByDate(String date) async {
    var response =
        await _dailyDietRepository.postSearchingDailyDietByDate(date);

    ResponseResultDailyDietModel responseResult =
        ResponseResultDailyDietModel.fromJson(response);

    DailyDietModel result = responseResult.data!;

    return result;
  }
}
