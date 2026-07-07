import '../core/api/api_client.dart';
import '../models/crop.dart';

class CropService {

  Future<List<Crop>> getAll() async {

    final response =
        await ApiClient.dio.get("/api/crops");

    return (response.data as List)

        .map((e) => Crop.fromJson(e))

        .toList();

  }

  Future<void> addCrop({

    required String cropName,

    required String variety,

    required String sowingDate,

    required String expectedHarvestDate,

    String? notes,

  }) async {

    await ApiClient.dio.post(

      "/api/crops",

      data: {

        "cropName": cropName,

        "variety": variety,

        "sowingDate": sowingDate,

        "expectedHarvestDate":
            expectedHarvestDate,

        "notes": notes,

      },

    );

  }

  Future<void> updateCrop({

    required String id,

    required String cropName,

    required String variety,

    required String sowingDate,

    required String expectedHarvestDate,

    String? notes,

  }) async {

    await ApiClient.dio.put(

      "/api/crops/$id",

      data: {

        "cropName": cropName,

        "variety": variety,

        "sowingDate": sowingDate,

        "expectedHarvestDate":
            expectedHarvestDate,

        "notes": notes,

      },

    );

  }

  Future<void> deleteCrop(
      String id) async {

    await ApiClient.dio.delete(
      "/api/crops/$id",
    );

  }

}