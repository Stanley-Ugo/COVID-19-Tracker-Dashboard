import '../../../../networking/barrel.dart';
import '../models/models.dart';

class CovidRepository {
  Future<CovidDataModel> fetchHistoricalData({required int noOfDays}) async {
    try {
      final response = await NetworkManager.getData(
        'https://disease.sh/v3/covid-19/historical/all?lastdays=$noOfDays',
      );

      if (NetworkManager.responseTrue(httpStatusCode: response.statusCode)) {
        return CovidDataModel.fromRawJson(response.body);
      } else {
        throw ApiException(message: "An error occurred loading this data");
      }
    } catch (e) {
      rethrow;
    }
  }
}
