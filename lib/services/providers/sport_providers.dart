import 'package:diet_app/models/daily_sport_model.dart';
import 'package:diet_app/models/sport_model.dart';
import 'package:diet_app/services/repository/sport_repository.dart';
import 'package:diet_app/utils/typedef.dart';

class SportProvider {
  final SportRepository _sportRepository;

  SportProvider(this._sportRepository);

  Future<List<SportModel>?> getAllSport() async {
    var response = await _sportRepository.getAllSport();

    ResponseResultSportModel responseResult =
        ResponseResultSportModel.fromJson(response);

    List<SportModel> result = responseResult.data!;

    return result;
  }

  Future<List<DailySportModel>?> getSport() async {
    var response = await _sportRepository.getSport();

    ResponseResultDailySportModel responseResult =
        ResponseResultDailySportModel.fromJson(response);

    List<DailySportModel> result = responseResult.data!;

    return result;
  }

  Future<JSON> postSport(JSON body) async {
    var response = await _sportRepository.postSport(body);
    return response;
  }

  Future delSport(int id) async {
    return await _sportRepository.delSport(id);
  }
}
