import '../core/api/api_client.dart';
import '../models/harvest.dart';

class HarvestService {

  Future<List<Harvest>> getAll() async {

    final response =
        await ApiClient.dio.get(
      "/api/harvests",
    );

    return (response.data as List)
        .map(
          (e) => Harvest.fromJson(e),
        )
        .toList();

  }

  Future<void> addHarvest({

    required String cropId,

    required String harvestDate,

    required double quantity,

    required String unit,

    required double rate,

  }) async {

    await ApiClient.dio.post(

      "/api/harvests",

      data: {

        "cropId": cropId,

        "harvestDate": harvestDate,

        "quantity": quantity,

        "unit": unit,

        "rate": rate,

      },

    );

  }

  Future<void> updateHarvest({

    required String id,

    required String cropId,

    required String harvestDate,

    required double quantity,

    required String unit,

    required double rate,

  }) async {

    await ApiClient.dio.put(

      "/api/harvests/$id",

      data: {

        "cropId": cropId,

        "harvestDate": harvestDate,

        "quantity": quantity,

        "unit": unit,

        "rate": rate,

      },

    );

  }

  Future<void> deleteHarvest(
      String id) async {

    await ApiClient.dio.delete(
      "/api/harvests/$id",
    );

  }

}